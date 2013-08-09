Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 723292C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Aug 2013 00:46:14 +1000 (EST)
Subject: Re: Pull request: scottwood/linux.git next
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1376028191.32100.13.camel@pasglop>
Date: Fri, 9 Aug 2013 09:43:37 -0500
Message-Id: <0C3278E8-558D-445B-A8F5-CCD0868C808C@kernel.crashing.org>
References: <20130808224501.GA8925@home.buserror.net>
 <1376028191.32100.13.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 9, 2013, at 1:03 AM, Benjamin Herrenschmidt wrote:

> On Thu, 2013-08-08 at 17:45 -0500, Scott Wood wrote:
>> The following changes since commit =
3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:
>>=20
>>  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)
>>=20
>> are available in the git repository at:
>=20
> Next time, put a little blurb at the head of the pull request giving a
> rough highlight, like I do when I send a pull request to Linus.
>=20
> Thanks !
>=20
> Cheers,
> Ben.

Also, I think we should pull a few of the commits in here out and submit =
for 3.11

     powerpc/msi: Fix compile error on mpc83xx
     powerpc/fsl_msi: fix error return code in fsl_of_msi_probe()
     powerpc/pci: fix PCI-e check link issue

- k

>=20
>>  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git =
next
>>=20
>> for you to fetch changes up to =
c8db32c8669f7de05b820ee4934926405af52188:
>>=20
>>  powerpc/e500: Update compilation flags with core specific options =
(2013-08-07 18:49:44 -0500)
>>=20
>> ----------------------------------------------------------------
>> Catalin Udma (2):
>>      powerpc/perf: increase the perf HW events to 6
>>      powerpc/e500: Update compilation flags with core specific =
options
>>=20
>> Dongsheng Wang (1):
>>      powerpc/mpc85xx: invalidate TLB after hibernation resume
>>=20
>> Haijun.Zhang (2):
>>      powerpc/85xx: add P1020RDB-PD platform support
>>      powerpc/85xx: add the P1020RDB-PD DTS support
>>=20
>> Hongtao Jia (3):
>>      powerpc: Move opcode definitions from kvm/emulate.c to =
asm/ppc-opcode.h
>>      powerpc/85xx: Add machine check handler to fix PCIe erratum on =
mpc85xx
>>      powerpc/msi: Fix compile error on mpc83xx
>>=20
>> Ian Campbell (1):
>>      powerpc/fsl-booke: Rename b4qds.dts -> b4qds.dtsi.
>>=20
>> Kevin Hao (3):
>>      powerpc/mpc85xx: remove the unneeded pci init functions for =
corenet ds board
>>      powerpc/fsl-pci: fix the unreachable warning message
>>      powerpc/fsl-pci: enable SWIOTLB in function setup_pci_atmu
>>=20
>> Laurentiu TUDOR (1):
>>      powerpc/85xx: Move ePAPR paravirt initialization earlier
>>=20
>> Lijun Pan (2):
>>      powerpc/perf: correct typos in counter enumeration
>>      powerpc/perf: add 2 additional performance monitor counters for =
e6500 core
>>=20
>> Minghuan Lian (3):
>>      powerpc/dts: update MSI bindings doc for MPIC v4.3
>>      powerpc/dts: add MPIC v4.3 dts node
>>      powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
>>=20
>> Priyanka Jain (1):
>>      powerpc/perf: Add e6500 PMU driver
>>=20
>> Wei Yongjun (1):
>>      powerpc/fsl_msi: fix error return code in fsl_of_msi_probe()
>>=20
>> Yuanquan Chen (1):
>>      powerpc/pci: fix PCI-e check link issue
>>=20
>> Zhenhua Luo (1):
>>      powerpc/fsl: Enable CONFIG_DEVTMPFS_MOUNT so /dev can be mounted =
correctly
>>=20
>> .../devicetree/bindings/powerpc/fsl/msi-pic.txt    |  53 +++-
>> arch/powerpc/Makefile                              |  18 +-
>> arch/powerpc/boot/dts/b4420qds.dts                 |   2 +-
>> arch/powerpc/boot/dts/b4860qds.dts                 |   2 +-
>> arch/powerpc/boot/dts/{b4qds.dts =3D> b4qds.dtsi}    |   0
>> arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |   2 +-
>> arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi       | 149 +++++++++++
>> arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |   2 +-
>> arch/powerpc/boot/dts/p1020rdb-pd.dts              | 280 =
+++++++++++++++++++++
>> arch/powerpc/configs/85xx/p1023rds_defconfig       |   1 +
>> arch/powerpc/configs/corenet32_smp_defconfig       |   1 +
>> arch/powerpc/configs/corenet64_smp_defconfig       |   1 +
>> arch/powerpc/configs/mpc83xx_defconfig             |   1 +
>> arch/powerpc/configs/mpc85xx_defconfig             |   1 +
>> arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 +
>> arch/powerpc/include/asm/epapr_hcalls.h            |   6 +
>> arch/powerpc/include/asm/mpic.h                    |   7 +
>> arch/powerpc/include/asm/perf_event_fsl_emb.h      |   2 +-
>> arch/powerpc/include/asm/ppc-opcode.h              |  47 ++++
>> arch/powerpc/include/asm/reg_fsl_emb.h             |  24 +-
>> arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
>> arch/powerpc/kernel/cputable.c                     |   2 +-
>> arch/powerpc/kernel/epapr_paravirt.c               |  28 ++-
>> arch/powerpc/kernel/setup_32.c                     |   4 +-
>> arch/powerpc/kernel/setup_64.c                     |   3 +
>> arch/powerpc/kernel/swsusp_booke.S                 |   8 +
>> arch/powerpc/kernel/traps.c                        |   3 +
>> arch/powerpc/kvm/emulate.c                         |  45 +---
>> arch/powerpc/oprofile/op_model_fsl_emb.c           |  30 +++
>> arch/powerpc/perf/Makefile                         |   2 +-
>> arch/powerpc/perf/core-fsl-emb.c                   |  30 +++
>> arch/powerpc/perf/e6500-pmu.c                      | 121 +++++++++
>> arch/powerpc/platforms/85xx/corenet_ds.c           |   6 -
>> arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  22 ++
>> arch/powerpc/sysdev/fsl_msi.c                      | 137 +++++++---
>> arch/powerpc/sysdev/fsl_msi.h                      |  10 +-
>> arch/powerpc/sysdev/fsl_pci.c                      | 184 =
++++++++++++--
>> arch/powerpc/sysdev/fsl_pci.h                      |   6 +
>> 38 files changed, 1088 insertions(+), 155 deletions(-)
>> rename arch/powerpc/boot/dts/{b4qds.dts =3D> b4qds.dtsi} (100%)
>> create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-mpic4.3.dtsi
>> create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dts
>> create mode 100644 arch/powerpc/perf/e6500-pmu.c
>=20
