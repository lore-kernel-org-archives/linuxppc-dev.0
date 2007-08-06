Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31B2ADDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 15:57:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l765vGdm028447
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Aug 2007 22:57:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l765vEXX009016
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 00:57:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Please pull powerpc.git merge branch
Date: Mon, 6 Aug 2007 13:57:14 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
In-Reply-To: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
References: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Paul,

How about following patches?

[PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC architecture with
ULI chip quirk functions.
URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040363.html
[PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and
MPC8544DS boards.
URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040364.html

[PATCH 1/3] Add a new member name to structure irq_host =20
URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039896.html
[PATCH 2/3] Add irq host name for all powerpc interrupt controllors.=20
URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039897.html
[PATCH 3/3] Add irq debugfs and virq_mapping for getting the virq=20
URL: http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039895.html


Thanks!

Best Regards,
Zhang Wei



> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Paul Mackerras
> Sent: Friday, August 03, 2007 6:33 PM
> To: torvalds@linux-foundation.org
> Cc: linuxppc-dev@ozlabs.org
> Subject: Please pull powerpc.git merge branch
>=20
> Linus,
>=20
> Please do
>=20
> git pull \
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
>=20
> to get another batch of bug-fixes for powerpc.
>=20
> Thanks,
> Paul.
>=20
>  arch/powerpc/kernel/entry_64.S            |    3 +++
>  arch/powerpc/kernel/pci_32.c              |    5 ++++-
>  arch/powerpc/kernel/smp.c                 |    9 +++------
>  arch/powerpc/mm/hash_low_64.S             |    6 ++++--
>  arch/powerpc/mm/hash_utils_64.c           |    2 +-
>  arch/powerpc/mm/numa.c                    |    4 ++--
>  arch/powerpc/mm/slb.c                     |   28=20
> ++++++++++++++++++----------
>  arch/powerpc/platforms/cell/spufs/sched.c |    3 ++-
>  arch/powerpc/platforms/powermac/feature.c |    6 ++++--
>  arch/powerpc/platforms/ps3/setup.c        |    2 +-
>  include/asm-powerpc/mmu-hash64.h          |    1 +
>  include/asm-powerpc/pgtable-64k.h         |    8 +++-----
>  12 files changed, 46 insertions(+), 31 deletions(-)
>=20
> Andre Detsch (1):
>       [POWERPC] spufs: Fix affinity after introduction of=20
> node_allowed() calls
>=20
> Kevin Corry (1):
>       [POWERPC] Fix num_cpus calculation in smp_call_function_map()
>=20
> Michael Ellerman (1):
>       [POWERPC] Fix parse_drconf_memory() for 64-bit start addresses
>=20
> Michael Neuling (1):
>       [POWERPC] Fixes for the SLB shadow buffer code
>=20
> Paul Mackerras (2):
>       [POWERPC] Expand RPN field to 34 bits when using 64k pages
>       [POWERPC] Fix special PTE code for secondary hash bucket
>=20
> Segher Boessenkool (2):
>       [POWERPC] Fix a compile warning in pci_32.c
>       [POWERPC] Fix a compile warning in powermac/feature.c
>=20
> Stephen Rothwell (1):
>       [POWERPC] ps3: Fix section mismatch in ps3/setup.c
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
