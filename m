Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id 7537867FE0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 14:17:18 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 82A8E467CD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 16:17:17 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 707294675B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Nov 2006 16:17:17 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8P00H017XV6G00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Tue, 14 Nov 2006 16:17:17 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J8P007IRAGSPUB0@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Tue, 14 Nov 2006 16:17:17 +1300 (NZDT)
Date: Tue, 14 Nov 2006 16:17:11 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Possibly OT: bdi2000 virtual memory on 2.6 kernel
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <45593537.1010604@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
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

Debugging a 2.6.18 kernel on a powerpc target with a bdi2000, I'm 
hitting a problem with not being able to read virtual addresses (i.e. 
those starting 0xc......). I get errors in gdb of the form:
     Cannot access memory at address 0xc023634c
I have CONFIG_BDI_SWITCH set and in the bdi config file I have MMU set 
to XLAT to (I thought) get the effective address.

I can set breakpoints OK and using ddd I get to the correct place in the 
source file but I can't then check and variables or structure due to 
this addressing problem.

I'm sure its something simple, I just can't see it at present!!

-- 
Robin

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
