Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 887F82BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 10:32:06 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id AE12310BA0D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 12:08:00 +1200 (NZST)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 2087B10B919
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Sep 2004 12:08:00 +1200 (NZST)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I4T00B01TIMPV00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 30 Sep 2004 12:05:25 +1200 (NZST)
Received: from [172.25.108.12] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0I4T00B3HUX0NC10@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Thu, 30 Sep 2004 12:05:24 +1200 (NZST)
Date: Thu, 30 Sep 2004 12:07:59 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <415B4E5F.6040107@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Subject: Status of uart driver on mpc8xx in 2.6
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings

Could anyone point me to a uart driver for mpc8xx as the one in 2.6.8.1 
obviously has not been hacked from the 2.4 variant since it still 
contains references to DECLARE_TASK_QUEUE and other things that have 
changed.

I'm sure there is a ppc 'special' tree that has all the necessary fixes 
but with this list disappearing for a while I've rather lost track of 
what is where!!

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
