Return-Path: <monstr@monstr.eu>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 33AC02C0159
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 04:37:47 +1000 (EST)
Received: by mail-ee0-f51.google.com with SMTP id c1so4440180eek.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 11:37:43 -0700 (PDT)
Message-ID: <520A7CEE.40003@monstr.eu>
Date: Tue, 13 Aug 2013 20:37:34 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com>
In-Reply-To: <520A536C.3030600@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xbXDxSd1h9n3WFdvg9iAm8K5BVVF5FBw0"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>,
 Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xbXDxSd1h9n3WFdvg9iAm8K5BVVF5FBw0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/13/2013 05:40 PM, Sudeep KarkadaNagesha wrote:
> Adding PowerPC list
>=20
> On 13/08/13 14:00, Rafael J. Wysocki wrote:
>> On Monday, August 12, 2013 02:27:47 PM Sudeep KarkadaNagesha wrote:
>>> The following changes since commit
>>> d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:
>>>
>>> Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)
>>>
>>> are available in the git repository at:
>>>
>>> git://linux-arm.org/linux-skn.git cpu_of_node
>>>
>>> for you to fetch changes up to
>>> 9e9e26dde91f22635c87d0e45f3938b5ded96f0d:
>>>
>>> cpufreq: pmac32-cpufreq: remove device tree parsing for cpu nodes=20
>>> (2013-08-12 10:22:29 +0100)
>>>
>>> ----------------------------------------------------------------=20
>>> Sudeep KarkadaNagesha (16): of: add support for retrieving cpu node
>>> for a given logical cpu index ARM: DT/kernel: define ARM specific
>>> arch_match_cpu_phys_id driver/core: cpu: initialize of_node in
>>> cpu's device struture of/device: add helper to get cpu device node
>>> from logical cpu index ARM: topology: remove hwid/MPIDR dependency
>>> from cpu_capacity ARM: mvebu: remove device tree parsing for cpu
>>> nodes drivers/bus: arm-cci: avoid parsing DT for cpu device nodes=20
>>> cpufreq: imx6q-cpufreq: remove device tree parsing for cpu nodes=20
>>> cpufreq: cpufreq-cpu0: remove device tree parsing for cpu nodes=20
>>> cpufreq: highbank-cpufreq: remove device tree parsing for cpu
>>> nodes cpufreq: spear-cpufreq: remove device tree parsing for cpu
>>> nodes cpufreq: kirkwood-cpufreq: remove device tree parsing for cpu
>>> nodes cpufreq: arm_big_little: remove device tree parsing for cpu
>>> nodes cpufreq: maple-cpufreq: remove device tree parsing for cpu
>>> nodes cpufreq: pmac64-cpufreq: remove device tree parsing for cpu
>>> nodes cpufreq: pmac32-cpufreq: remove device tree parsing for cpu
>>> nodes
>>>
>>> arch/arm/kernel/devtree.c           |  5 +++++=20
>>> arch/arm/kernel/topology.c          | 61=20
>>> +++++++++++++++++++------------------------------------------=20
>>> arch/arm/mach-imx/mach-imx6q.c      |  3 +--=20
>>> arch/arm/mach-mvebu/platsmp.c       | 52=20
>>> ++++++++++++++++++++++++----------------------------=20
>>> drivers/base/cpu.c                  |  2 ++ drivers/bus/arm-cci.c
>>> | 28 +++++++---------------------=20
>>> drivers/cpufreq/arm_big_little_dt.c | 40=20
>>> ++++++++++++++--------------------------=20
>>> drivers/cpufreq/cpufreq-cpu0.c      | 23 ++++-------------------=20
>>> drivers/cpufreq/highbank-cpufreq.c  | 18 ++++++------------=20
>>> drivers/cpufreq/imx6q-cpufreq.c     |  4 +---=20
>>> drivers/cpufreq/kirkwood-cpufreq.c  |  8 +++++---=20
>>> drivers/cpufreq/maple-cpufreq.c     | 23 +++--------------------=20
>>> drivers/cpufreq/pmac32-cpufreq.c    |  5 +++--=20
>>> drivers/cpufreq/pmac64-cpufreq.c    | 47=20
>>> +++++++++++------------------------------------=20
>>> drivers/cpufreq/spear-cpufreq.c     |  4 ++-- drivers/of/base.c
>>> | 73=20
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>>>
>>>
> include/linux/cpu.h                 |  1 +
>>> include/linux/of.h                  |  6 ++++++=20
>>> include/linux/of_device.h           | 15 +++++++++++++++ 19 files
>>> changed, 202 insertions(+), 216 deletions(-)
>>>
>>>
>>> PS: This patch series is reviewed and acknowledged @
>>>
>>> v1: https://lkml.org/lkml/2013/7/15/128 v2:
>>> https://lkml.org/lkml/2013/7/17/341 v3:
>>> https://lkml.org/lkml/2013/7/22/219
>>
>> Pulled, thanks!
>>
> Hi Rob, Rafael,
>=20
> On 13/08/13 15:16, kbuild test robot wrote:> tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> bleeding-edge
>> head:   0d4bcb5dc7d3040c0ce7572ea30ab9e5d9455bfa commit:
>> 7939ff8d991de2c0b15064e76ee549a6df5ae67f [151/204] of: add
>> support for retrieving cpu node for a given logical cpu index
>> config: make ARCH=3Dpowerpc allmodconfig
>>
>> All error/warnings:
>>
>> warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
>> selects FSL_LBC which has unmet direct dependencies (FSL_SOC)
>> warning: (MPC836x_RDK && MTD_NAND_FSL_ELBC && MTD_NAND_FSL_UPM)
>> selects FSL_LBC which has unmet direct dependencies (FSL_SOC)
>> In file included from arch/powerpc/include/asm/kvm_para.h:26:0, from
>> include/uapi/linux/kvm_para.h:26, from include/linux/kvm_para.h:4,=20
>> from include/linux/kvm_host.h:30, from
>> arch/powerpc/kernel/asm-offsets.c:53:
>> include/linux/of.h:269:28: error: conflicting types for
>> 'of_get_cpu_node'
>> extern struct device_node *of_get_cpu_node(int cpu); ^ In file
>> included from include/linux/of.h:139:0, from
>> arch/powerpc/include/asm/kvm_para.h:26, from
>> include/uapi/linux/kvm_para.h:26, from include/linux/kvm_para.h:4,=20
>> from include/linux/kvm_host.h:30, from
>> arch/powerpc/kernel/asm-offsets.c:53:=20
>> arch/powerpc/include/asm/prom.h:47:21: note: previous declaration
>> of 'of_get_cpu_node' was here
>> struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);=20
>> ^ make[2]: *** [arch/powerpc/kernel/asm-offsets.s] Error 1 make[2]:
>> Target `__build' not remade because of errors. make[1]: ***
>> [prepare0] Error 2 make[1]: Target `prepare' not remade because of
>> errors. make: *** [sub-make] Error 2
>>
>=20
> There seems to be conflict in the new function "of_get_cpu_node" added.=

> PowerPC also defines the same function name. Further microblaze and
> openrisc declares it(can be removed) but doesn't define it.

Feel free to remove it for Microblaze.
There was probably any reason why it was there.
Or maybe no reason and it was just there because Microblaze
was based on powerpc code.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--xbXDxSd1h9n3WFdvg9iAm8K5BVVF5FBw0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlIKfO8ACgkQykllyylKDCE2GwCfTwLE16LiJKnNRp7CdaAZZkrT
ZNAAnRntqG5ehBcJN4fMBinwErC8pJQJ
=w/Pr
-----END PGP SIGNATURE-----

--xbXDxSd1h9n3WFdvg9iAm8K5BVVF5FBw0--
