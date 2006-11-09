Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (gatekeeper.tait.co.nz [202.37.96.11])
	by ozlabs.org (Postfix) with ESMTP id 9A53C67C67
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Nov 2006 12:31:47 +1100 (EST)
Received: from gatekeeper.tait.co.nz (localhost.localdomain [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id BCF33467C6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Nov 2006 14:31:46 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (sunstrike [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id A889D46756
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Nov 2006 14:31:46 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0J8F00A01U8UCD00@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 09 Nov 2006 14:31:46 +1300 (NZDT)
Date: Thu, 09 Nov 2006 14:31:33 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: Freescale combined ethernet driver
In-reply-to: <45525367.10502@heckheck.com>
To: Jim Heck <jsurf@heckheck.com>
Message-id: <455284F5.3070901@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <45515913.3080206@tait.co.nz> <45525367.10502@heckheck.com>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
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

Jim Heck wrote:
> Assuming you have a filesystem and can get some software onto it (with 
> the network not up...), the package 'iproute' contains the 'ip' tool 
> that would quickly show you the name of the device using the command.
> 

I've given up on the Freescale driver as its obviously broken and gone 
back to the intermediate one (not the 8xx_io one!!) so I have a network 
connection now (on eth0).

No filesystem yet as I've yet to write a platform support map for the 
flash, initrd (ramfs) fails with an oops and root nfs fails as well even 
though it manages the mount, it says it can't find an init (same fs on 
2.4 is fine!!).

My head hurts...

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
