Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CEBDB6F92
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 00:03:24 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1306387374.7481.451.camel@pasglop>
Date: Thu, 26 May 2011 09:02:45 -0500
Message-Id: <C1E4ECF7-17CD-4A32-941D-FE53137F94EC@kernel.crashing.org>
References: <1306387374.7481.451.camel@pasglop>
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


On May 26, 2011, at 12:22 AM, Benjamin Herrenschmidt wrote:

> Hi Linus !
>=20
> This is a bit more than I expected to send you that late in the merge
> window, but hopefully none of it should be problematic. A couple of
> patches were simply delayed due to misunderstandings as to which tree
> they should go through (4xx MSI and ftrace).
>=20
> There's a generic patch to linux/smp.h which removes some definitions
> that as far as we can tell aren't used anywhere anymore (we just =
removed
> the last use in powerpc in my previous pull request).
>=20
> The rest is either good enough bug fixes (in large part regressions),
> with a couple more cleanups from Milton on top of his big series that
> I merged earlier.
>=20
> Cheers,
> Ben.
>=20
> The following changes since commit =
3f5785ec31adcb7cafa9135087297a38d9698cf8:
>=20
>  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6 =
(2011-05-25 17:00:17 -0700)
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git =
..BRANCH.NOT.VERIFIED..
>=20
> Brian King (1):
>      powerpc/pseries: Update MAX_HCALL_OPCODE to reflect page =
coalescing
>=20
> Eric B Munson (1):
>      powerpc/oprofile: Handle events that raise an exception without =
overflowing
>=20
> Ian Munsie (1):
>      powerpc/ftrace: Implement raw syscall tracepoints on PowerPC
>=20
> Milton Miller (8):
>      Remove unused MSG_ flags in linux/smp.h
>      powerpc/cell: Use common smp ipi actions
>      powerpc/cell: Rename ipi functions to match current abstractions
>      powerpc/irq: Remove stale and misleading comment
>      powerpc/irq: Always free duplicate IRQ_LEGACY hosts
>      powerpc/irq: Check desc in handle_one_irq and expand =
generic_handle_irq
>      powerpc/irq: Protect irq_radix_revmap_lookup against =
irq_free_virt
>      powerpc: Fix irq_free_virt by adjusting bounds before loop
>=20
> Rupjyoti Sarmah (1):
>      powerpc/4xx: Adding PCIe MSI support

Ben,

Did you ignore my pull request with a bug fix and two long standing RIO =
patches?

- k=
