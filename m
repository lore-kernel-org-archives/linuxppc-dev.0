Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C78CCB6EEC
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 06:25:26 +1100 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326435694.23910.229.camel@pasglop>
Date: Mon, 16 Jan 2012 13:21:51 -0600
Message-Id: <5742F9CB-77C0-40AF-9719-B55AB2C17D8C@kernel.crashing.org>
References: <1326435694.23910.229.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 13, 2012, at 12:21 AM, Benjamin Herrenschmidt wrote:

> Hi Linus !
>=20
> Please pull this couple of important bug fixes (a commit
> that went in breaks booting on some machines, this fixes
> it properly).
>=20
> Thanks !
>=20
> Cheers,
> Ben.
>=20
> The following changes since commit =
7b3480f8b701170c046e1ed362946f5f0d005e13:
>=20
>  Merge tag 'for-linus-3.3' of git://git.infradead.org/mtd-2.6 =
(2012-01-10 13:45:22 -0800)
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>=20
> Anton Blanchard (1):
>      powerpc: Fix RCU idle and hcall tracing
>=20
> Li Zhong (1):
>      powerpc: Fix unpaired __trace_hcall_entry and __trace_hcall_exit
>=20
> arch/powerpc/kernel/idle.c              |   12 ++----------
> arch/powerpc/platforms/pseries/hvCall.S |    3 ++-
> arch/powerpc/platforms/pseries/lpar.c   |   14 ++++++++++----
> 3 files changed, 14 insertions(+), 15 deletions(-)

Ben,

This doesnt appear to have the compile fix for p1022_ds.c.

- k=
