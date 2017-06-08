Return-Path: <krzk@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk9Np1NdmzDqN7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 02:09:46 +1000 (AEST)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Joachim Eastwood <manabian@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Steven Miao <realmz6@gmail.com>,
 Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>,
 Mikael Starvik <starvik@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Richard Kuo <rkuo@codeaurora.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, David Howells <dhowells@redhat.com>,
 Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S. Miller" <davem@davemloft.net>,
 Chris Metcalf <cmetcalf@mellanox.com>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
 linux-am33-list@redhat.com, nios2-dev@lists.rocketboards.org,
 openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/35] defconfig: Cleanup from old entries
Date: Thu,  8 Jun 2017 18:08:36 +0200
Message-Id: <20170608160836.12196-1-krzk@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

While cleaning Samsung ARM defconfigs with savedefconfig, I encountered
similar obsolete entries in other files.

Except the ARM, no dependencies.
For ARM, the rest of patches depend on the first change (otherwise
it might not apply cleanly).


Best regards,
Krzysztof

Krzysztof Kozlowski (35):
  ARM: defconfig: Cleanup from old Kconfig options
  MIPS: defconfig: Cleanup from old Kconfig options
  blackfin: defconfig: Cleanup from old Kconfig options
  c6x: defconfig: Cleanup from old Kconfig options
  m32r: defconfig: Cleanup from old Kconfig options
  sh: defconfig: Cleanup from old Kconfig options
  x86: defconfig: Cleanup from old Kconfig options
  cris: defconfig: Cleanup from old Kconfig options
  parisc: defconfig: Cleanup from old Kconfig options
  sparc: defconfig: Cleanup from old Kconfig options
  hexagon: defconfig: Cleanup from old Kconfig options
  microblaze: defconfig: Cleanup from old Kconfig options
  mn10300: defconfig: Cleanup from old Kconfig options
  score: defconfig: Cleanup from old Kconfig options
  unicore32: defconfig: Cleanup from old Kconfig options
  alpha: defconfig: Cleanup from old Kconfig options
  ARC: defconfig: Cleanup from old Kconfig options
  m68k: defconfig: Cleanup from old Kconfig options
  nios2: defconfig: Cleanup from old Kconfig options
  openrisc: defconfig: Cleanup from old Kconfig options
  powerpc: defconfig: Cleanup from old Kconfig options
  um: defconfig: Cleanup from old Kconfig options
  tile: defconfig: Cleanup from old Kconfig options
  ARM: defconfig: samsung: Re-order entries to match savedefconfig
  ARM: mini2440_defconfig: Bring back lost (but wanted) options
  ARM: tct_hammer_defconfig: Bring back lost (but wanted) options
  ARM: s3c2410_defconfig: Bring back lost (but wanted) options
  ARM: s3c6400_defconfig: Bring back lost (but wanted) options
  ARM: s5pv210_defconfig: Bring back lost (but wanted) options
  ARM: exynos_defconfig: Save defconfig
  ARM: s3c2410_defconfig: Save defconfig
  ARM: mini2440_defconfig: Save defconfig
  ARM: s3c6400_defconfig: Save defconfig
  ARM: s5pv210_defconfig: Save defconfig
  ARM: tct_hammer_defconfig: Save defconfig

 arch/alpha/defconfig                              |  2 -
 arch/arc/configs/nps_defconfig                    |  1 -
 arch/arc/configs/tb10x_defconfig                  |  1 -
 arch/arm/configs/acs5k_defconfig                  |  8 --
 arch/arm/configs/acs5k_tiny_defconfig             | 10 ---
 arch/arm/configs/am200epdkit_defconfig            |  7 --
 arch/arm/configs/assabet_defconfig                |  3 -
 arch/arm/configs/axm55xx_defconfig                |  1 -
 arch/arm/configs/badge4_defconfig                 |  5 --
 arch/arm/configs/cerfcube_defconfig               |  4 -
 arch/arm/configs/cm_x2xx_defconfig                | 13 ----
 arch/arm/configs/cm_x300_defconfig                | 10 ---
 arch/arm/configs/cns3420vb_defconfig              |  7 --
 arch/arm/configs/colibri_pxa270_defconfig         | 13 ----
 arch/arm/configs/colibri_pxa300_defconfig         |  9 ---
 arch/arm/configs/collie_defconfig                 |  4 -
 arch/arm/configs/corgi_defconfig                  | 13 ----
 arch/arm/configs/dove_defconfig                   |  1 -
 arch/arm/configs/ebsa110_defconfig                |  1 -
 arch/arm/configs/efm32_defconfig                  |  1 -
 arch/arm/configs/em_x270_defconfig                | 13 ----
 arch/arm/configs/ep93xx_defconfig                 |  1 -
 arch/arm/configs/eseries_pxa_defconfig            |  8 --
 arch/arm/configs/exynos_defconfig                 |  6 +-
 arch/arm/configs/ezx_defconfig                    | 18 -----
 arch/arm/configs/footbridge_defconfig             |  1 -
 arch/arm/configs/h5000_defconfig                  |  6 --
 arch/arm/configs/hackkit_defconfig                |  3 -
 arch/arm/configs/imote2_defconfig                 | 16 ----
 arch/arm/configs/imx_v4_v5_defconfig              |  1 -
 arch/arm/configs/iop13xx_defconfig                |  4 -
 arch/arm/configs/iop32x_defconfig                 |  5 --
 arch/arm/configs/iop33x_defconfig                 |  6 --
 arch/arm/configs/ixp4xx_defconfig                 |  9 ---
 arch/arm/configs/jornada720_defconfig             |  8 --
 arch/arm/configs/ks8695_defconfig                 |  7 --
 arch/arm/configs/lart_defconfig                   |  3 -
 arch/arm/configs/lpc18xx_defconfig                |  1 -
 arch/arm/configs/lpd270_defconfig                 |  5 --
 arch/arm/configs/lubbock_defconfig                |  4 -
 arch/arm/configs/magician_defconfig               | 15 ----
 arch/arm/configs/mainstone_defconfig              |  4 -
 arch/arm/configs/mini2440_defconfig               | 91 +++++++----------------
 arch/arm/configs/mmp2_defconfig                   |  9 ---
 arch/arm/configs/moxart_defconfig                 |  1 -
 arch/arm/configs/mps2_defconfig                   |  1 -
 arch/arm/configs/mv78xx0_defconfig                |  8 --
 arch/arm/configs/mxs_defconfig                    |  1 -
 arch/arm/configs/neponset_defconfig               |  4 -
 arch/arm/configs/netwinder_defconfig              |  3 -
 arch/arm/configs/netx_defconfig                   |  6 --
 arch/arm/configs/nhk8815_defconfig                |  1 -
 arch/arm/configs/nuc910_defconfig                 |  7 --
 arch/arm/configs/nuc950_defconfig                 |  7 --
 arch/arm/configs/nuc960_defconfig                 |  7 --
 arch/arm/configs/omap1_defconfig                  |  2 -
 arch/arm/configs/orion5x_defconfig                |  2 -
 arch/arm/configs/palmz72_defconfig                |  6 --
 arch/arm/configs/pcm027_defconfig                 |  8 --
 arch/arm/configs/pleb_defconfig                   |  3 -
 arch/arm/configs/pxa168_defconfig                 |  9 ---
 arch/arm/configs/pxa255-idp_defconfig             |  4 -
 arch/arm/configs/pxa3xx_defconfig                 |  9 ---
 arch/arm/configs/pxa910_defconfig                 |  9 ---
 arch/arm/configs/pxa_defconfig                    |  2 -
 arch/arm/configs/qcom_defconfig                   |  1 -
 arch/arm/configs/raumfeld_defconfig               | 11 ---
 arch/arm/configs/realview_defconfig               |  1 -
 arch/arm/configs/rpc_defconfig                    |  6 --
 arch/arm/configs/s3c2410_defconfig                | 38 +++-------
 arch/arm/configs/s3c6400_defconfig                | 18 +----
 arch/arm/configs/s5pv210_defconfig                | 28 +++----
 arch/arm/configs/sama5_defconfig                  |  1 -
 arch/arm/configs/shannon_defconfig                |  3 -
 arch/arm/configs/simpad_defconfig                 |  7 --
 arch/arm/configs/spear13xx_defconfig              |  4 -
 arch/arm/configs/spear3xx_defconfig               |  4 -
 arch/arm/configs/spear6xx_defconfig               |  3 -
 arch/arm/configs/spitz_defconfig                  | 13 ----
 arch/arm/configs/sunxi_defconfig                  |  1 -
 arch/arm/configs/tct_hammer_defconfig             | 15 +---
 arch/arm/configs/trizeps4_defconfig               |  8 --
 arch/arm/configs/u300_defconfig                   |  1 -
 arch/arm/configs/vexpress_defconfig               |  1 -
 arch/arm/configs/viper_defconfig                  |  9 ---
 arch/arm/configs/xcep_defconfig                   |  8 --
 arch/arm/configs/zeus_defconfig                   | 10 ---
 arch/arm/configs/zx_defconfig                     |  2 -
 arch/blackfin/configs/BF518F-EZBRD_defconfig      |  2 -
 arch/blackfin/configs/BF526-EZBRD_defconfig       |  3 -
 arch/blackfin/configs/BF527-AD7160-EVAL_defconfig |  2 -
 arch/blackfin/configs/BF527-EZKIT-V2_defconfig    |  3 -
 arch/blackfin/configs/BF527-EZKIT_defconfig       |  3 -
 arch/blackfin/configs/BF527-TLL6527M_defconfig    |  6 --
 arch/blackfin/configs/BF533-EZKIT_defconfig       |  2 -
 arch/blackfin/configs/BF533-STAMP_defconfig       |  2 -
 arch/blackfin/configs/BF537-STAMP_defconfig       |  2 -
 arch/blackfin/configs/BF538-EZKIT_defconfig       |  5 --
 arch/blackfin/configs/BF548-EZKIT_defconfig       |  3 -
 arch/blackfin/configs/BF561-ACVILON_defconfig     |  6 --
 arch/blackfin/configs/BF561-EZKIT-SMP_defconfig   |  2 -
 arch/blackfin/configs/BF561-EZKIT_defconfig       |  2 -
 arch/blackfin/configs/BF609-EZKIT_defconfig       |  1 -
 arch/blackfin/configs/BlackStamp_defconfig        |  6 --
 arch/blackfin/configs/CM-BF527_defconfig          |  6 --
 arch/blackfin/configs/CM-BF533_defconfig          |  4 -
 arch/blackfin/configs/CM-BF537E_defconfig         |  5 --
 arch/blackfin/configs/CM-BF537U_defconfig         |  4 -
 arch/blackfin/configs/CM-BF548_defconfig          |  7 --
 arch/blackfin/configs/CM-BF561_defconfig          |  5 --
 arch/blackfin/configs/DNP5370_defconfig           |  6 --
 arch/blackfin/configs/H8606_defconfig             |  4 -
 arch/blackfin/configs/IP0X_defconfig              |  3 -
 arch/blackfin/configs/PNAV-10_defconfig           |  5 --
 arch/blackfin/configs/SRV1_defconfig              |  4 -
 arch/blackfin/configs/TCM-BF518_defconfig         |  6 --
 arch/blackfin/configs/TCM-BF537_defconfig         |  4 -
 arch/c6x/configs/dsk6455_defconfig                |  2 -
 arch/c6x/configs/evmc6457_defconfig               |  2 -
 arch/c6x/configs/evmc6472_defconfig               |  2 -
 arch/c6x/configs/evmc6474_defconfig               |  2 -
 arch/c6x/configs/evmc6678_defconfig               |  2 -
 arch/cris/configs/artpec_3_defconfig              |  2 -
 arch/cris/configs/dev88_defconfig                 |  1 -
 arch/cris/configs/etrax-100lx_defconfig           |  1 -
 arch/cris/configs/etrax-100lx_v2_defconfig        |  2 -
 arch/cris/configs/etraxfs_defconfig               |  2 -
 arch/hexagon/configs/comet_defconfig              |  5 --
 arch/m32r/configs/m32104ut_defconfig              |  4 -
 arch/m32r/configs/m32700ut.smp_defconfig          |  3 -
 arch/m32r/configs/m32700ut.up_defconfig           |  3 -
 arch/m32r/configs/mappi.nommu_defconfig           |  2 -
 arch/m32r/configs/mappi.smp_defconfig             |  4 -
 arch/m32r/configs/mappi.up_defconfig              |  4 -
 arch/m32r/configs/mappi2.opsp_defconfig           |  2 -
 arch/m32r/configs/mappi2.vdec2_defconfig          |  2 -
 arch/m32r/configs/mappi3.smp_defconfig            |  4 -
 arch/m32r/configs/oaks32r_defconfig               |  2 -
 arch/m32r/configs/opsput_defconfig                |  2 -
 arch/m32r/configs/usrv_defconfig                  |  5 --
 arch/m68k/configs/m5208evb_defconfig              |  1 -
 arch/m68k/configs/m5249evb_defconfig              |  1 -
 arch/m68k/configs/m5272c3_defconfig               |  1 -
 arch/m68k/configs/m5275evb_defconfig              |  1 -
 arch/m68k/configs/m5307c3_defconfig               |  1 -
 arch/m68k/configs/m5407c3_defconfig               |  1 -
 arch/microblaze/configs/mmu_defconfig             |  1 -
 arch/microblaze/configs/nommu_defconfig           |  3 -
 arch/mips/configs/ar7_defconfig                   |  6 --
 arch/mips/configs/ath79_defconfig                 |  2 -
 arch/mips/configs/bcm63xx_defconfig               |  7 --
 arch/mips/configs/bigsur_defconfig                |  4 -
 arch/mips/configs/bmips_be_defconfig              |  1 -
 arch/mips/configs/capcella_defconfig              |  4 -
 arch/mips/configs/cavium_octeon_defconfig         |  1 -
 arch/mips/configs/ci20_defconfig                  |  1 -
 arch/mips/configs/cobalt_defconfig                |  8 --
 arch/mips/configs/decstation_defconfig            |  1 -
 arch/mips/configs/e55_defconfig                   |  2 -
 arch/mips/configs/fuloong2e_defconfig             | 11 ---
 arch/mips/configs/gpr_defconfig                   |  8 --
 arch/mips/configs/ip22_defconfig                  | 11 ---
 arch/mips/configs/ip27_defconfig                  |  5 --
 arch/mips/configs/ip28_defconfig                  |  5 --
 arch/mips/configs/ip32_defconfig                  |  8 --
 arch/mips/configs/jazz_defconfig                  |  6 --
 arch/mips/configs/jmr3927_defconfig               |  7 --
 arch/mips/configs/lasat_defconfig                 |  5 --
 arch/mips/configs/lemote2f_defconfig              | 12 ---
 arch/mips/configs/loongson3_defconfig             |  3 -
 arch/mips/configs/malta_kvm_defconfig             |  1 -
 arch/mips/configs/malta_kvm_guest_defconfig       |  1 -
 arch/mips/configs/malta_qemu_32r6_defconfig       |  1 -
 arch/mips/configs/maltaaprp_defconfig             |  2 -
 arch/mips/configs/maltasmvp_defconfig             |  1 -
 arch/mips/configs/maltasmvp_eva_defconfig         |  2 -
 arch/mips/configs/maltaup_defconfig               |  2 -
 arch/mips/configs/markeins_defconfig              |  4 -
 arch/mips/configs/mips_paravirt_defconfig         |  1 -
 arch/mips/configs/mpc30x_defconfig                |  5 --
 arch/mips/configs/msp71xx_defconfig               |  2 -
 arch/mips/configs/mtx1_defconfig                  | 11 ---
 arch/mips/configs/nlm_xlp_defconfig               |  5 --
 arch/mips/configs/nlm_xlr_defconfig               |  9 ---
 arch/mips/configs/pnx8335_stb225_defconfig        |  7 --
 arch/mips/configs/qi_lb60_defconfig               |  3 -
 arch/mips/configs/rb532_defconfig                 |  6 --
 arch/mips/configs/rbtx49xx_defconfig              |  7 --
 arch/mips/configs/rm200_defconfig                 |  8 --
 arch/mips/configs/rt305x_defconfig                |  2 -
 arch/mips/configs/sb1250_swarm_defconfig          |  1 -
 arch/mips/configs/tb0219_defconfig                |  6 --
 arch/mips/configs/tb0226_defconfig                |  7 --
 arch/mips/configs/tb0287_defconfig                |  5 --
 arch/mips/configs/workpad_defconfig               |  4 -
 arch/mn10300/configs/asb2303_defconfig            |  6 --
 arch/mn10300/configs/asb2364_defconfig            |  8 --
 arch/nios2/configs/10m50_defconfig                |  1 -
 arch/nios2/configs/3c120_defconfig                |  1 -
 arch/openrisc/configs/or1ksim_defconfig           |  1 -
 arch/parisc/configs/712_defconfig                 |  5 --
 arch/parisc/configs/a500_defconfig                |  6 --
 arch/parisc/configs/b180_defconfig                |  3 -
 arch/parisc/configs/c3000_defconfig               |  5 --
 arch/parisc/configs/default_defconfig             |  5 --
 arch/parisc/configs/generic-32bit_defconfig       |  2 -
 arch/powerpc/configs/c2k_defconfig                |  1 -
 arch/powerpc/configs/ppc6xx_defconfig             |  1 -
 arch/score/configs/spct6600_defconfig             |  8 --
 arch/sh/configs/ap325rxa_defconfig                | 10 ---
 arch/sh/configs/apsh4a3a_defconfig                |  9 ---
 arch/sh/configs/apsh4ad0a_defconfig               |  6 --
 arch/sh/configs/cayman_defconfig                  |  4 -
 arch/sh/configs/dreamcast_defconfig               |  6 --
 arch/sh/configs/ecovec24-romimage_defconfig       |  7 --
 arch/sh/configs/ecovec24_defconfig                |  9 ---
 arch/sh/configs/edosk7705_defconfig               |  2 -
 arch/sh/configs/edosk7760_defconfig               | 11 ---
 arch/sh/configs/espt_defconfig                    | 10 ---
 arch/sh/configs/hp6xx_defconfig                   |  4 -
 arch/sh/configs/kfr2r09-romimage_defconfig        |  5 --
 arch/sh/configs/kfr2r09_defconfig                 |  7 --
 arch/sh/configs/landisk_defconfig                 |  4 -
 arch/sh/configs/lboxre2_defconfig                 |  3 -
 arch/sh/configs/magicpanelr2_defconfig            |  9 ---
 arch/sh/configs/microdev_defconfig                |  3 -
 arch/sh/configs/migor_defconfig                   |  8 --
 arch/sh/configs/polaris_defconfig                 |  9 ---
 arch/sh/configs/r7780mp_defconfig                 |  4 -
 arch/sh/configs/r7785rp_defconfig                 |  3 -
 arch/sh/configs/rsk7201_defconfig                 |  8 --
 arch/sh/configs/rsk7203_defconfig                 | 10 ---
 arch/sh/configs/rsk7264_defconfig                 |  3 -
 arch/sh/configs/rsk7269_defconfig                 |  4 -
 arch/sh/configs/rts7751r2d1_defconfig             |  5 --
 arch/sh/configs/rts7751r2dplus_defconfig          |  8 --
 arch/sh/configs/sdk7780_defconfig                 |  9 ---
 arch/sh/configs/sdk7786_defconfig                 |  9 ---
 arch/sh/configs/se7206_defconfig                  |  8 --
 arch/sh/configs/se7343_defconfig                  |  9 ---
 arch/sh/configs/se7619_defconfig                  |  5 --
 arch/sh/configs/se7705_defconfig                  |  5 --
 arch/sh/configs/se7712_defconfig                  |  7 --
 arch/sh/configs/se7721_defconfig                  |  6 --
 arch/sh/configs/se7722_defconfig                  |  3 -
 arch/sh/configs/se7724_defconfig                  |  9 ---
 arch/sh/configs/se7750_defconfig                  |  5 --
 arch/sh/configs/se7751_defconfig                  |  5 --
 arch/sh/configs/se7780_defconfig                  |  7 --
 arch/sh/configs/secureedge5410_defconfig          |  9 ---
 arch/sh/configs/sh03_defconfig                    |  4 -
 arch/sh/configs/sh2007_defconfig                  |  8 --
 arch/sh/configs/sh7710voipgw_defconfig            |  5 --
 arch/sh/configs/sh7724_generic_defconfig          |  3 -
 arch/sh/configs/sh7757lcr_defconfig               |  4 -
 arch/sh/configs/sh7763rdp_defconfig               |  9 ---
 arch/sh/configs/sh7770_generic_defconfig          |  3 -
 arch/sh/configs/sh7785lcr_32bit_defconfig         | 10 ---
 arch/sh/configs/sh7785lcr_defconfig               |  9 ---
 arch/sh/configs/shmin_defconfig                   |  4 -
 arch/sh/configs/shx3_defconfig                    |  6 --
 arch/sh/configs/titan_defconfig                   |  8 --
 arch/sh/configs/ul2_defconfig                     |  9 ---
 arch/sh/configs/urquell_defconfig                 |  9 ---
 arch/sparc/configs/sparc32_defconfig              |  4 -
 arch/sparc/configs/sparc64_defconfig              |  4 -
 arch/tile/configs/tilegx_defconfig                |  1 -
 arch/tile/configs/tilepro_defconfig               |  2 -
 arch/um/configs/i386_defconfig                    |  1 -
 arch/um/configs/x86_64_defconfig                  |  1 -
 arch/unicore32/configs/unicore32_defconfig        |  4 -
 arch/x86/configs/i386_defconfig                   |  3 -
 arch/x86/configs/x86_64_defconfig                 |  3 -
 273 files changed, 52 insertions(+), 1437 deletions(-)

-- 
2.9.3
