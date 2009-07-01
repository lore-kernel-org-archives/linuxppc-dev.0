Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D4745B70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 05:52:23 +1000 (EST)
Received: by bwz17 with SMTP id 17so1183530bwz.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jul 2009 12:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
Date: Wed, 1 Jul 2009 21:52:19 +0200
Message-ID: <1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 1, 2009 at 8:04 PM, Mikhail
Zaturenskiy<mzaturenskiy.st@gmail.com> wrote:
> Hello,
> I'm trying to get a ramdisk working on my EP88xc with uboot and linux
> kernel v2.6.30. The ramdisk image is from
> ELDK_4.2/ppc_8xx/images/uRamdisk.
>
> At first I thought my issue was similar to
> http://ozlabs.org/pipermail/linuxppc-embedded/2008-August/031204.html
> but I'm not so sure anymore. I think my problem is with incorrectly
> configuring my kernel.
>

Hi Mikhail,
Try setting CONFIG_EXT2_FS=y, then recompile your kernel and reboot.
- Frank
