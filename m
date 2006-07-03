Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5F6A067B32
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jul 2006 03:10:57 +1000 (EST)
Message-ID: <44A940F3.1090901@ovro.caltech.edu>
Date: Mon, 03 Jul 2006 09:08:19 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Ben Warren <bwarren@qstreams.com>
Subject: Re: JFFS2 FS is read-only (not what I want)
References: <44A6E57A.3080302@qstreams.com>
In-Reply-To: <44A6E57A.3080302@qstreams.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ben Warren wrote:
> Hello,
> 
> When I boot from a JFFS2 file system on my eval board, the file system 
> is effectively read-only, and I can't figure out why.  I'm pretty sure 
> the kernel's configured for R/W MTD block access.  Any help is greatly 
> appreciated.

The default uboot command line on the 8349E was:

bootargs=root=/dev/mtdblock1 rootfstype=jffs2 rw console=ttyS0,115200

so I suspect you have dropped the rw ... try adding that.

> The hardware in use is:
> 
> Freescale MPC8349EMDS eval board.
> 8MB Q-flash with 64 uniform 128k sectors

I'm also working with that board, feel free to contact me off
list and we can compare notes.

When I've finished my evaluation I'll post a link to the list
for anyone else thats interested.

Cheers
Dave
