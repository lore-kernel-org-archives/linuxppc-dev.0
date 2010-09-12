Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 00/11] treewide: Remove pr_<level> uses with KERN_<level>
Date: Sat, 11 Sep 2010 22:10:48 -0700
Message-Id: <cover.1284267142.git.joe@perches.com>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Steve Wise <swise@opengridcomputing.com>,
	Tom Tucker <tom@opengridcomputing.com>, Jaroslav Kysela <perex@perex.cz>,
	Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Sean Hefty <sean.hefty@intel.com>, devel@driverdev.osuosl.org,
	David Brownell <dbrownell@users.sourceforge.net>,
	Russell King <linux@arm.linux.org.uk>,
	linux-rdma@vger.kernel.org, x86@kernel.org,
	Alexander Graf <agraf@suse.de>, Ingo Molnar <mingo@redhat.com>,
	Avi Kivity <avi@redhat.com>, Hal Rosenstock <hal.rosenstock@gmail.com>,
	cbe-oss-dev@lists.ozlabs.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	microblaze-uclinux@itee.uq.edu.au, kvm-ppc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lrg@slimlogic.co.uk>, Michal Simek <monstr@monstr.eu>,
	Eric Miao <eric.y.miao@gmail.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	Geoff Levand <geoff@infradead.org>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of these are pr_debug(KERN_<foo>.
pr_<level>(KERN_<level> is unnecessary.

Joe Perches (11):
  arch/arm: Remove pr_<level> uses of KERN_<level>
  arch/avr32: Remove pr_<level> uses of KERN_<level>
  arch/microblaze: Remove pr_<level> uses of KERN_<level>
  arch/mips: Remove pr_<level> uses of KERN_<level>
  arch/powerpc: Remove pr_<level> uses of KERN_<level>
  arch/x86: Remove pr_<level> uses of KERN_<level>
  drivers/infiniband: Remove pr_<level> uses of KERN_<level>
  drivers/net/skfp: Remove pr_<level> uses of KERN_<level>
  drivers/staging/msm: Remove pr_<level> uses of KERN_<level>
  drivers/usb/gadget: Remove pr_<level> uses of KERN_<level>
  sound: Remove pr_<level> uses of KERN_<level>

 arch/arm/mach-pxa/cpufreq-pxa2xx.c       |    3 +-
 arch/avr32/mach-at32ap/at32ap700x.c      |    4 +-
 arch/microblaze/kernel/exceptions.c      |   16 ++----
 arch/mips/kernel/irq-gic.c               |    2 +-
 arch/mips/pci/pci-rc32434.c              |    2 +-
 arch/powerpc/kvm/emulate.c               |    4 +-
 arch/powerpc/sysdev/pmi.c                |    2 +-
 arch/x86/kernel/apb_timer.c              |    4 +-
 drivers/infiniband/hw/amso1100/c2_intr.c |    4 +-
 drivers/net/skfp/skfddi.c                |   84 +++++++++++++++---------------
 drivers/staging/msm/staging-devices.c    |    2 +-
 drivers/usb/gadget/r8a66597-udc.c        |    2 +-
 sound/ppc/snd_ps3.c                      |    2 +-
 sound/soc/s3c24xx/s3c-dma.c              |    3 +-
 14 files changed, 64 insertions(+), 70 deletions(-)

-- 
1.7.3.rc1
