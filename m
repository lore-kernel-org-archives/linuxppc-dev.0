Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id 825BCDDD02
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 01:55:37 +1100 (EST)
Subject: Re: [PATCH] jffs2 file system
From: Ben Warren <bwarren@qstreams.com>
To: Nethra <nethra_gmit@yahoo.co.in>
In-Reply-To: <9113399.post@talk.nabble.com>
References: <9097247.post@talk.nabble.com>
	<200702221128.02970.juergen.beisert@weihenstephan.org>
	<9097618.post@talk.nabble.com>
	<200702221229.51830.juergen.beisert@weihenstephan.org>
	<9113399.post@talk.nabble.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 09:55:31 -0500
Message-Id: <1172242531.22834.138.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-22 at 20:28 -0800, Nethra wrote:
> 
> thanks...
> 
> what are the steps to create jffs2 image?
> 
Here's a good link on building a JFFS2 filesystem:
http://www.denx.de/wiki/view/DULG/RootFileSystemOnAJFFS2FileSystem

> do i need to disable nfs option in kernel?
No.  Both can happily co-exist
> 
> what r steps for jffs2 mounting after nfs mounting on the board?
> 
Try:

mount -t jffs2 -o ro /dev/mtdblockX /<mount_path>

I'd recommend booting to an NFS filesystem.  Once in Linux, you can try
mounting the JFFS2 block and debug from there.  Once you have that
working, try booting to JFFS2 via the MTD_PHYSMAP methods.

regards,
Ben
