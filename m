Return-Path: <rpjday@mindspring.com>
Received: from tomts22-srv.bellnexxia.net (tomts22.bellnexxia.net
	[209.226.175.184]) by ozlabs.org (Postfix) with ESMTP id 22C2B6805F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 15:13:27 +1000 (EST)
Date: Mon, 22 Aug 2005 23:24:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: JohnsonCheng <johnsoncheng@qnap.com.tw>
In-Reply-To: <20050823031136.2904C68046@ozlabs.org>
Message-ID: <Pine.LNX.4.63.0508222323480.18519@localhost.localdomain>
References: <20050823031136.2904C68046@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Linux Kernel MTD question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 23 Jul 2005, JohnsonCheng wrote:

> Yes. You are right. It's design by myself.
> But I meet a problem. If I have three configuration files, A.conf, B.conf
> and C.conf, then I hope save them in one of partitions of MTD,
> 0x005C0000-0x10000000.
> Two questions:
> 1. How to build these configuration files into an image for U-boot with
> mkimage?
> 2. In kernel, how to get these data? I use "mount /dev/mtd4 /mnt", but it
> failed by block device required.

for this second issue, you might try mounting the block device, which
is probably called /dev/mtdblock4 or something similar.

rday
