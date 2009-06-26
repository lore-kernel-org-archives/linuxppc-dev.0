Return-Path: <mzaturenskiy.st@gmail.com>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.240])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E062CB707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 03:13:08 +1000 (EST)
Received: by rv-out-0708.google.com with SMTP id k29so784227rvb.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 10:13:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A44FD90.2040607@freescale.com>
References: <97dd5fd20906260913x351593c9raa429fd657eb42f0@mail.gmail.com>
	<4A44FD90.2040607@freescale.com>
From: Mikhail Zaturenskiy <mzaturenskiy.st@gmail.com>
Date: Fri, 26 Jun 2009 12:12:47 -0500
Message-ID: <97dd5fd20906261012h34a85b33j9183eb9e41ed1181@mail.gmail.com>
Subject: Re: Trouble "Transferring control to Linux (at address 00000000)"
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

Hi Scott,

> This isn't the denx list;
I've noticed :) but I'm still learning about this whole process so I
though I could get some general suggestions.

> what kernel version is that, and with what
> modifications from mainline?
Kernel is v2.6.30, I'm not yet familiar enough with it to know what's
been modified from mainline, just following instructions.

> Note that ep88xc.dts in mainline is intended for use with PlanetCore, whi=
ch
> is what ships on that board. =A0You may need to make modifications for it=
 to
> work with u-boot (at the least, the IMMR base is probably different).
Hmm, this hasn't occurred to me, thank you for pointing it out.

> Also, make sure u-boot is properly updating the memory size in the device
> tree. =A0Can you dump the post-fixup device tree in u-boot?
Not sure, but I'll try to find out if that's possible. It'd certainly
answer a lot of questions...

Thanks,
Mikhail Zaturenskiy
