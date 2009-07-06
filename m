Return-Path: <mzaturenskiy.st@gmail.com>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2E8C8B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jul 2009 04:30:06 +1000 (EST)
Received: by qyk1 with SMTP id 1so4500952qyk.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 06 Jul 2009 11:30:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A4D2B70.1030505@freescale.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
	<1ba63b520907020010u46a3b495h79672fc4f6d84c14@mail.gmail.com>
	<97dd5fd20907020643s52cc65aah8ee315c3592d5e1@mail.gmail.com>
	<4A4CBC0C.1040001@mlbassoc.com>
	<97dd5fd20907020927v2680a7f8m2657193394bd6323@mail.gmail.com>
	<97dd5fd20907021142i663de6aavc093fbd6ac5025c@mail.gmail.com>
	<1ba63b520907021338n3c0d6d33g11d4934ccc538a94@mail.gmail.com>
	<97dd5fd20907021438ve8c72b9g168e4aa22e9f2f9f@mail.gmail.com>
	<4A4D2B70.1030505@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Mon, 6 Jul 2009 13:29:45 -0500
Message-ID: <97dd5fd20907061129k67d2404m7e2a2c8fd8a71503@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: Scott Wood <scottwood@freescale.com>
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

> If you have time, could you bisect to see when the slowdown was introduced?
>
> -Scott
>

Scott, I tested with kernels 2.6.28, 2.6.29 and 2.6.30 all obtained
from git.kernel.org and configured the same.
So, on my EP88xc board 2.6.28 and 2.6.29 work ok, 2.6.30 has the
slowdown issue after loading a ramdisk.

After doing this testing I have a side question:
If I modify just arch/powerpc/configs/ep88x_defconfig, not all changes
are reflected in the resulting .config when i do "make
ep88x_defconfig; make uImage". I ended up having to modify
arch/powerpc/Kconfig, arch/powerpc/configs/ep88xc_defconfig,
fs/ext2/Kconfig and init/Kconfig to get "make ep88x_defconfig; make
uImage" to create a properly configured image, but this really doesn't
feel right. What's the proper way to set up a defconfig?

Thanks,
Mikhail Zaturenskiy
