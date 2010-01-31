Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 3E625B7D6A
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Feb 2010 07:02:21 +1100 (EST)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] treewide: Fix format strings that misuse continuations
Date: Sun, 31 Jan 2010 12:02:02 -0800
Message-Id: <cover.1264967493.git.joe@perches.com>
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@suse.de>,
	Christoph Lameter <cl@linux-foundation.org>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	linux-ide@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	Paul Mackerras <paulus@samba.org>,
	Sonic Zhang <sonic.zhang@analog.com>, devel@driverdev.osuosl.org,
	linux-scsi@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mike Frysinger <vapier@gentoo.org>, Pekka Enberg <penberg@cs.helsinki.fi>,
	Matt Mackall <mpm@selenic.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>,
	uclinux-dist-devel@blackfin.uclinux.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Format strings that are continued with \ are frequently misused.
Change them to use mostly single line formats, some longer than 80 chars.
Fix a few miscellaneous typos at the same time.

Joe Perches (10):
  arch/powerpc: Fix continuation line formats
  arch/blackfin: Fix continuation line formats
  drivers/ide: Fix continuation line formats
  drivers/serial/bfin_5xx.c: Fix continuation line formats
  drivers/scsi/arcmsr: Fix continuation line formats
  drivers/staging: Fix continuation line formats
  drivers/net/amd8111e.c: Fix continuation line formats
  fs/proc/array.c: Fix continuation line formats
  mm/slab.c: Fix continuation line formats
  sound/soc/blackfin: Fix continuation line formats

 arch/blackfin/mach-common/smp.c                    |    4 +-
 arch/powerpc/kernel/nvram_64.c                     |    6 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |    8 ++--
 arch/powerpc/platforms/pseries/smp.c               |    4 +-
 drivers/ide/au1xxx-ide.c                           |    4 +-
 drivers/ide/pmac.c                                 |    4 +-
 drivers/net/amd8111e.c                             |    3 +-
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   49 +++++++++----------
 drivers/serial/bfin_5xx.c                          |    6 +--
 drivers/staging/dream/qdsp5/audio_mp3.c            |    3 +-
 .../rtl8187se/ieee80211/ieee80211_softmac_wx.c     |    3 +-
 drivers/staging/rtl8187se/r8180_core.c             |    3 +-
 drivers/staging/sep/sep_driver.c                   |    3 +-
 fs/proc/array.c                                    |    7 ++-
 mm/slab.c                                          |    4 +-
 sound/soc/blackfin/bf5xx-ac97-pcm.c                |    8 +--
 sound/soc/blackfin/bf5xx-i2s-pcm.c                 |    3 +-
 sound/soc/blackfin/bf5xx-tdm-pcm.c                 |    3 +-
 18 files changed, 55 insertions(+), 70 deletions(-)
