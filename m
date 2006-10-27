Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id 56F0A67CF6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 11:58:31 +1000 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id CA036467C6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 14:41:20 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id B904F4675C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Oct 2006 14:41:20 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J7R00501SKG8G00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Fri, 27 Oct 2006 14:41:20 +1300 (NZDT)
Received: from [172.25.140.15] by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	with ESMTP id <0J7R000YWU0UJL70@sunstrike.tait.co.nz> for
	linuxppc-embedded@ozlabs.org; Fri, 27 Oct 2006 14:41:19 +1300 (NZDT)
Date: Fri, 27 Oct 2006 14:41:06 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Building new FEC code on 8xx with 2.6.17 kernel
To: ppc embedded list <linuxppc-embedded@ozlabs.org>
Message-id: <454163B2.4010308@tait.co.nz>
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

Just having a first stab at building for an 859T based product so I 
assume I'll be using the new FEC driver. I'm getting two unresolved 
references as follows:

drivers/built-in.o: In function 
`fec_8xx_init':fec_main.c:(.init.text+0x1a40): undefined reference to 
`fec_8xx_platform_init'
drivers/built-in.o: In function 
`fec_8xx_cleanup':fec_main.c:(.exit.text+0x39c): undefined reference to 
`fec_8xx_platform_cleanup'

No big deal as I can see an example for the netta platform (whatever 
that is) that defines these functions and I can hack that to suit my 
hardware - what I can't find is where CONFIG_NETTA is defined. I can't 
find it in any Kconfig file, and I want to use the same mechanism for 
selecting my platform.

Any ideas? (or is FEC still broken on CPM1 processors)

Cheers

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
