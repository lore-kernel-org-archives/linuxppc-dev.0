Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id ABE8EB70B2
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 17:00:53 +1000 (EST)
Received: by iwn36 with SMTP id 36so1150681iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jul 2010 00:00:52 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 30 Jul 2010 00:00:52 -0700
Message-ID: <AANLkTinKb8E_McVAv5epg+4acb8H1+8HNsKHJYDr9B10@mail.gmail.com>
Subject: ramdisk size is larger than 4MB
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a ramdisk as RFS much larger than 4MB in a 2.4 kernel. In
recent 2.6 kernels ramdisk is no longer supported so I decided to go
with initramfs. However I found the initial RFS for initramfs is
limited to 4MB since the bootwrapper locates at 0x400000.

One way to lift this limitation is to relocate the bootwrapper to
somewhere else, say for example, 0x1000000 so that a 16MB initramfs
can be loaded. If the bootwrapper is relocated, what else would be
affected by this relocation?

Another (better?) way may be to find a right file system for RFS such
as JFFS2. My board has limited NOR flash (32MB) but larger RAM
(128MB). There is not much space left in flash for RFS.

Would you like to share some thoughts?

Thanks a lot,
-Shawn.
