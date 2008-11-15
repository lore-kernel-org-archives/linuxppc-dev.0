Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id 315BEDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Nov 2008 21:46:07 +1100 (EST)
Date: Sat, 15 Nov 2008 01:40:21 -0900 (AKST)
From: Nicholas Mc Guire <hofrat@hofr.at>
To: Cristian Axenie <cristian.axenie@gmail.com>
Subject: Re: USB Flash rootfs prep!
In-Reply-To: <9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0811150138440.4494@vlab.hofr.at>
References: <9c789a000811141705k245e4447k8a9be8e4f180c3f8@mail.gmail.com>
	<1226737139.17218.14.camel@md40100b.ft>
	<9c789a000811150112q3088a044ub8b38489b2119a60@mail.gmail.com>
	<9c789a000811150112i484baa39y846bbf38ed6e1bb8@mail.gmail.com>
	<Pine.LNX.4.58.0811150051230.4465@vlab.hofr.at>
	<9c789a000811150217o3c08e94ar3f99eda848822e62@mail.gmail.com>
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

> >
> > did you check that it is actually a valid character device (c 5 1) ?
> > it can easaly happend during copying of a tree into your image that
> > they become regular files.
> >
> > hofrat
> >
> I think that you are right, butr how can I test this validity??
>
just check with ls -l that the device file is actually still a character
device with the right major/minor number.

crw--w--w-    1 root     tty        5,   1 Nov 13 22:18 /mnt/dev/console

modes and date of course may be diferent.

hofrat
