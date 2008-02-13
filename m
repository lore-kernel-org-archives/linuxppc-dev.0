Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB575DDF04
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 13:49:12 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1D2n9RS029083
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:49:09 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1D2n9xA206450
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:49:09 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1D2n8X8003060
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 21:49:08 -0500
Date: Tue, 12 Feb 2008 20:48:02 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH] FIx compile of swim3 as module
Message-ID: <20080212204802.18a7a868@zod.rchland.ibm.com>
In-Reply-To: <20080213024019.GX6887@bakeyournoodle.com>
References: <20080213024019.GX6887@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, kyle@mcmartin.ca,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 13 Feb 2008 13:40:20 +1100
tony@bakeyournoodle.com (Tony Breeds) wrote:

> The current pmac32_defconfig fails to build with the following error:
> 
>   Building modules, stage 2.
> ERROR: "check_media_bay" [drivers/block/swim3.ko] undefined!
> WARNING: modpost: Found 23 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> make[2]: *** [__modpost] Error 1
> 
> This patch fixes that.

Kyle posted a slightly different patch that seemed to still keep
the original intention of ifdefery in tact.  I've no idea which is
better, but the three of you might want to compare notes.

josh
