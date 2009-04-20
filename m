Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id A1D8ADDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 07:18:47 +1000 (EST)
Received: by gxk1 with SMTP id 1so4888285gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 14:18:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904162258i450c86e9k303933d41405c89b@mail.gmail.com>
References: <fa686aa40904162258i450c86e9k303933d41405c89b@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 20 Apr 2009 15:10:36 -0600
Message-ID: <fa686aa40904201410h766bcc98tfa4a1bc293fe61d1@mail.gmail.com>
Subject: Re: Please pull merge branch from git.secretlab.ca
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben/Paul,

Here's an updated pull request with 5200 defconfig updates and a
bugfix to prom_parse.c

Cheers,
g.

The following changes since commit 0882e8dd3aad33eca41696d463bb896e6c8817eb=
:
  Linus Torvalds (1):
        Linux 2.6.30-rc2

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Anton Vorontsov (1):
      powerpc/5200: Bring the legacy fsl_spi_platform_data hooks back

Grant Likely (2):
      powerpc/5200: Add FLASH nodes to lite5200 device tree
      powerpc/5200: defconfig updates

Ilpo J=E4rvinen (1):
      powerpc: Fix of_node_put() exit path in of_irq_map_one()

Stefan Roese (2):
      powerpc/of-device-tree: Factor MTD physmap bindings out of
booting-without-of
      powerpc/device-tree: Document MTD nodes with multiple "reg" tuples

 Documentation/powerpc/booting-without-of.txt       |   89 ++--------
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |   80 +++++++++
 arch/powerpc/boot/dts/lite5200b.dts                |   39 ++++
 arch/powerpc/configs/52xx/cm5200_defconfig         |   69 +++++--
 arch/powerpc/configs/52xx/lite5200b_defconfig      |   74 ++++++--
 arch/powerpc/configs/52xx/motionpro_defconfig      |   77 ++++++--
 arch/powerpc/configs/52xx/pcm030_defconfig         |   69 +++++--
 arch/powerpc/configs/52xx/tqm5200_defconfig        |   76 ++++++--
 arch/powerpc/configs/mpc5200_defconfig             |  188 ++++++++++++++++=
----
 arch/powerpc/kernel/prom_parse.c                   |   11 +-
 include/linux/fsl_devices.h                        |    4 +
 11 files changed, 568 insertions(+), 208 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt


On Thu, Apr 16, 2009 at 11:58 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Hi Ben/Paul,
>
> Here are some fixups and documentation updates for 2.6.30
>
> The following changes since commit 0882e8dd3aad33eca41696d463bb896e6c8817=
eb:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.30-rc2
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 merge
>
> Anton Vorontsov (1):
> =A0 =A0 =A0powerpc/5200: Bring the legacy fsl_spi_platform_data hooks bac=
k
>
> Grant Likely (1):
> =A0 =A0 =A0powerpc/5200: Add FLASH nodes to lite5200 device tree
>
> Stefan Roese (2):
> =A0 =A0 =A0powerpc/of-device-tree: Factor MTD physmap bindings out of
> booting-without-of
> =A0 =A0 =A0powerpc/device-tree: Document MTD nodes with multiple "reg" tu=
ples
>
> =A0Documentation/powerpc/booting-without-of.txt =A0 =A0 =A0 | =A0 89 +++-=
----------------
> =A0Documentation/powerpc/dts-bindings/mtd-physmap.txt | =A0 80 ++++++++++=
++++++++
> =A0arch/powerpc/boot/dts/lite5200b.dts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 39 +++++++++
> =A0include/linux/fsl_devices.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 =A04 +
> =A04 files changed, 135 insertions(+), 77 deletions(-)
> =A0create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
