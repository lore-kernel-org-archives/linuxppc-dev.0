Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 24AFEDDE29
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2007 10:14:19 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 00/13] CPU selection Kconfig cleanup, take 3
Date: Sun, 17 Jun 2007 02:14:10 +0200
References: <20070612163016.253915076@arndb.de>
	<200706150151.40056.arnd@arndb.de>
	<21B37470-5341-4AC7-9334-B58F0BCFAAC9@kernel.crashing.org>
In-Reply-To: <21B37470-5341-4AC7-9334-B58F0BCFAAC9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706170214.11247.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 17 June 2007, Kumar Gala wrote:
> > For the 'at least one option selected' argument, I'm not sure how
> > important that is, IMHO it falls into the same category as any
> > other essential option that you can disable.
>=20
> People have run into the issue so I think it desires at least a =A0
> little concern. =A0See: http://marc.info/?t=3D117529164800005&r=3D1&w=3D2

But isn't the reported problem just a bug in the build system?
My impression was that the user did not complain about the fact
that the kernel he was trying to build would not boot on any
platform, but rather that the kernel tried to build a zImage
that was not defined, resulting in a build error.

Obviously, any configuration that can be selected by the user
should be able to compile and link without errors, even if it's
not particularly useful.

Aside from the multiplatform enabling patches, are you happy with
the patches 1-8 from my fourth version of the patch set?

	Arnd <><
