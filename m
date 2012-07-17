Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA8CF2C00BA
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 23:45:58 +1000 (EST)
Subject: Re: [PATCH] powerpc/85xx: remove P1020RDB and P2020RDB CAMP device
 trees
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342219243-8061-1-git-send-email-timur@freescale.com>
Date: Tue, 17 Jul 2012 08:38:23 -0500
Message-Id: <5455FE42-4686-4B0C-8051-1F1495E00C93@kernel.crashing.org>
References: <1342219243-8061-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 13, 2012, at 5:40 PM, Timur Tabi wrote:

> We only need two examples of CAMP device trees in the upstream kernel.
>=20
> Co-operative Asymmetric Multi-Processing (CAMP) is a technique where =
two
> or more operating systems (typically multiple copies of the same Linux =
kernel)
> are loaded into memory, and each kernel is given a subset of the =
available
> cores to execute on.  For example, on a four-core system, one kernel =
runs on
> cores 0 and 1, and the other runs on cores 2 and 3.
>=20
> The devices are also partitioned among the operating systems, and this =
is
> done with customized device trees.  Each kernel gets its own device =
tree
> that has only the devices that it should know about.
>=20
> Unfortunately, this approach is very hackish.  The kernels are trusted =
to
> only access devices in their respective device trees, and the =
partitioning
> only works for devices that can be handled.  Crafting the device trees =
is a
> tricky process, and getting U-Boot to load and start all kernels is =
cumbersome.
>=20
> But most importantly, each CAMP setup is very application-specific, =
since
> the actual partitioning of resources is done in the DTS by the system
> designer.  Therefore, it doesn't make a lot of sense to have a lot of =
CAMP
> device trees, since we only expect them to be used as examples.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |   63 -----------
> arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |  141 =
-------------------------
> arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |   67 ------------
> arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  125 =
----------------------
> 4 files changed, 0 insertions(+), 396 deletions(-)
> delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
> delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
> delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
> delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts

applied to next

- k=
