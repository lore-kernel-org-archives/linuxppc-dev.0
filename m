Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3E96B6F6E
	for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2011 15:32:15 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1305777978.7481.37.camel@pasglop>
Date: Thu, 19 May 2011 00:32:07 -0500
Message-Id: <4092C878-9A76-4D78-AF84-15120FDA102A@kernel.crashing.org>
References: <1305777978.7481.37.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 18, 2011, at 11:06 PM, Benjamin Herrenschmidt wrote:

> Hi Linus
>=20
> Dunno if it's too late or not yet but here's 3 fixes for powerpc that
> would be welcome to have in before the release. If not I'll send them
> first thing next (one of them is already in -next in fact).
>=20
> Those are regression fixes and a build breakage.
>=20
> Cheers,
> Ben.
>=20
> The following changes since commit =
fce519588acfac249e8fdc1f5016c73d617de315:
>=20
>  Merge branch 'devicetree/merge' of =
git://git.secretlab.ca/git/linux-2.6 (2011-05-18 13:25:57 -0700)
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>=20
> Ben Hutchings (1):
>      powerpc/kexec: Fix build failure on 32-bit SMP
>=20
> Benjamin Herrenschmidt (1):
>      powerpc/smp: Make start_secondary_resume available to all CPU =
variants
>=20
> kerstin jonsson (1):
>      powerpc/4xx: Fix regression in SMP on 476
>=20
> arch/powerpc/kernel/crash.c   |   59 =
+++++++++++++++++++++--------------------
> arch/powerpc/kernel/head_32.S |    9 ------
> arch/powerpc/kernel/misc_32.S |   11 +++++++
> arch/powerpc/kernel/smp.c     |    4 +-
> 4 files changed, 43 insertions(+), 40 deletions(-)
>=20

Can you pull this into next.

- k=
