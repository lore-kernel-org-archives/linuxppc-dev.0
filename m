Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (unknown [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 675F02BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 14:31:47 +1100 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id A51E610BA0D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 16:07:50 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 0588A10BA83
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Dec 2004 16:07:50 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0I8400701JGHL400@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Fri, 03 Dec 2004 16:07:49 +1300 (NZDT)
Received: from [172.25.114.91] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0I8400N0SM110O80@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Fri, 03 Dec 2004 16:07:49 +1300 (NZDT)
Date: Fri, 03 Dec 2004 16:07:49 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <41AFD885.60007@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Subject: Current PID in static kernel memory
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

On a 2.4.22 kernel running on an 8xx CPU, I'm trying to find useful 
static kernel memory locations that will help diagnose problems after a 
crash has occured.

So far I have identified load averages, uptime, active & inactive memory 
and interrupt counts and I can dump these out from the bootloader.

What I'd really like is the pid of the current task but I can't find it 
as the current task structure pointer is held in a register (r2) and 
hence is not available after a reset.

Any clues as to where I could find this information?

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
