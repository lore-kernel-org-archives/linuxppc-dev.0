Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D2FCB7DFB
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 20:24:17 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1273650396.21352.121.camel@pasglop>
Date: Wed, 12 May 2010 05:24:04 -0500
Message-Id: <B0104965-09F9-4372-AA9F-F6D0FDEA67F2@kernel.crashing.org>
References: <1273650396.21352.121.camel@pasglop>
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


On May 12, 2010, at 2:46 AM, Benjamin Herrenschmidt wrote:

> Hi Linus !
>=20
> Please pull this perf event fix from Paulus. Without it, using perf =
event
> can potentially oops the machine at any time.
>=20
> Thanks !
>=20
> Cheers,
> Ben.
>=20
> The following changes since commit =
cea0d767c29669bf89f86e4aee46ef462d2ebae8:
>  Linus Torvalds (1):
>        Merge branch 'hwmon-for-linus' of =
git://git.kernel.org/.../jdelvare/staging
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
>=20
> Paul Mackerras (1):
>      powerpc/perf_event: Fix oops due to perf_event_do_pending call
>=20
> arch/powerpc/include/asm/hw_irq.h |   38 -----------------------
> arch/powerpc/kernel/asm-offsets.c |    1 -
> arch/powerpc/kernel/entry_64.S    |    9 -----
> arch/powerpc/kernel/irq.c         |    6 ----
> arch/powerpc/kernel/time.c        |   60 =
+++++++++++++++++++++++++++++-------
> 5 files changed, 48 insertions(+), 66 deletions(-)
>=20

Ben,

Did where you going to also send linus:

http://patchwork.ozlabs.org/patch/51496/

- k=
