Return-Path: <scottwood@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6999B7082
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 Jan 2011 09:07:22 +1100 (EST)
Date: Mon, 3 Jan 2011 16:07:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexandru Ionut Grama <gramaalexandruionut@gmail.com>
Subject: Re: problem backporting talitos for MPC8272
Message-ID: <20110103160706.4329947c@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTikjjGGd5h7TsQtEuSjX3qhJv3wC28UtWHtJ19jo@mail.gmail.com>
References: <AANLkTikjjGGd5h7TsQtEuSjX3qhJv3wC28UtWHtJ19jo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Dec 2010 02:10:55 +0100
Alexandru Ionut Grama <gramaalexandruionut@gmail.com> wrote:

> My final question it's about of-tree. I have the mpc8272ads.dts file with=
 a
> tree that involves talitos, but I've changed the properties acording the =
new
> version of it on 2.6.35. =C2=BFThis file (mpc8272ads.dts) when it's used?=
I think
> I don't use this file for nothing (it doesn't appears on make V=3D1) beca=
use I
> don't have a normal bootloader and I have to load the kernel like a
> flat-binary gz, so there's no more step after building System.map.

IIRC, in 2.6.21, it wasn't used on 82xx (I think there was only
arch/ppc support for 82xx, or at best 82xx arch/powerpc support was
just getting started).  2.6.21 is very old, and doing new development on
it is not recommended.

Why not work with the current kernel?

-Scott
