Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 0E99CB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 06:14:42 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so1606155rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jul 2009 13:14:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
References: <97dd5fd20907011104t773c3fc9tca7f0fe56ea22477@mail.gmail.com>
	<1ba63b520907011252w4c1e9abck65cba3791f57260f@mail.gmail.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Wed, 1 Jul 2009 15:14:21 -0500
Message-ID: <97dd5fd20907011314j1974728fs745bbc62e2b1e6ec@mail.gmail.com>
Subject: Re: RAMDISK on EP88xc
To: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
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

> Hi Mikhail,
> Try setting CONFIG_EXT2_FS=y, then recompile your kernel and reboot.

Hi Frank, just tried that but still getting the same "Unpacking
initramfs... failed!" output
