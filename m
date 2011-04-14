Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEF67B6F4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 19:19:00 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p3E9ItVD032176
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2011 11:18:55 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Where is CONFIG_BOOT_LOAD ?
Date: Thu, 14 Apr 2011 11:18:54 +0200
References: <201104081128.37906.dargaud@lpsc.in2p3.fr>
	<201104081458.43831.dargaud@lpsc.in2p3.fr>
	<4DA485CD.6060604@gmx.de>
In-Reply-To: <4DA485CD.6060604@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201104141118.55001.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 12 April 2011 19:03:09 Joachim F=F6rster wrote:
> Note that the default 0x400... is the link address of the zImage wrapper
> rather than the one of THE kernel.

Yes, and I need more space for the uncompression to take place when using a=
 ramdisk.

> Currently the link address seems to be hard-coded into
> arch/powerpc/boot/wrapper
> (a shell script). Since long ago I'm wondering why the maintainers did
> that. But I guess there is a reason, because it wasn't that way in the
> old arch/ppc days ;-) ...

Thanks for that. I'd been using "objcopy --change-addresses" to relocate th=
e elf file with success.

> Is configuring the zImage-piggy-back-loader through menuconfig & co evil?

That seems like a good idea. Maybe add some way to figure out if the uncomp=
ressed kernel overlaps the zImage wrapper ?
=2D-=20
Guillaume Dargaud
http://www.gdargaud.net/Antarctica/
