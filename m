Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 7F963DDDF6
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 21:27:59 +1100 (EST)
Date: Sat, 15 Nov 2008 01:01:20 -0900 (AKST)
From: Nicholas Mc Guire <hofrat@hofr.at>
To: Cristian Axenie <cristian.axenie@gmail.com>
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> >
> >
> > On Sat, Nov 15, 2008 at 10:18 AM, Joachim Foerster <mls.JOFT@gmx.de>wrote:
> >
> >> Hi Cristian,
> >>
> >> On Sat, 2008-11-15 at 03:05 +0200, Cristian Axenie wrote:
> >> > VFS: Mounted root (ext2 filesystem) readonly.
> >> > Freeing unused kernel memory: 156k init
> >> > Warning: unable to open an initial console.
> >>
> >> Device file /dev/console doesn't seem to exist in your rootfs.
> >
> > Strange because /dev/console exists in my ext2.img.

did you check that it is actually a valid character device (c 5 1) ?
it can easaly happend during copying of a tree into your image that
they become regular files.

hofrat
