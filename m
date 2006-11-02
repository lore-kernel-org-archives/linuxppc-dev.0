Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id 8B5F967C32
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 11:25:44 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 344214675B
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 13:25:44 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 20F1146751
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Nov 2006 13:25:44 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8200D01RM7R800@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 02 Nov 2006 13:25:44 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J82008VRUIVKWF0@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Thu, 02 Nov 2006 13:25:43 +1300 (NZDT)
Date: Thu, 02 Nov 2006 13:25:43 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: 2.6.18 on mpc859t stuck in __delay
To: linuxppc-embedded@ozlabs.org
Message-id: <45493B07.7030806@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm sure this is a common one but I'm a bit stuck (like the target is 
really!!)

I'm real confused about what options to enable for a generic 866 series 
target - I'm got CONFIG_MPC86xADS and CONFIG_FADS enabled in the 
platform section but I'm not clear as to whether that will cause the 
startup code to look for an ADS EPROM chip or look for a bd_t struct of 
data from the bootloader.

I've checked the bdinfo at __res and it looks OK (booting from u-boot) 
with valid CPU, bus and console speeds but I get the impression that the 
decrementer isn't being started.

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
