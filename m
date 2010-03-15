Return-Path: <swirl@gmx.li>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1F3C9B7D8C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 07:56:19 +1100 (EST)
From: Thomas Weber <swirl@gmx.li>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some typo fixing
Date: Mon, 15 Mar 2010 21:55:43 +0100
Message-Id: <1268686558-28171-1-git-send-email-swirl@gmx.li>
Cc: Karsten Keil <isdn@linux-pingi.de>, Lin Ming <ming.m.lin@intel.com>,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Pavel Machek <pavel@suse.cz>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-acpi@vger.kernel.org,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Rusty Russell <rusty@rustcorp.com.au>, Li Zefan <lizf@cn.fujitsu.com>,
	Steve Conklin <sconklin@canonical.com>,
	Ralph Campbell <infinipath@qlogic.com>,
	Anton Vorontsov <avorontsov@ru.mvista.com>, cbe-oss-dev@ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>, Anthony Liguori <aliguori@us.ibm.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Randy Dunlap <rdunlap@xenotime.net>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-media@vger.kernel.org, Pieter Palmers <pieterp@joow.be>,
	Anand Gadiyar <gadiyar@ti.com>, alsa-devel@alsa-project.org,
	linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Clemens Ladisch <clemens@ladisch.de>, linux-mm@kvack.org,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	=?UTF-8?q?H=C3=A5kan=20Johansson?= <f96hajo@chalmers.se>,
	linux-s390@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	linuxppc-dev@ozlabs.org, Dave Airlie <airlied@redhat.com>,
	Tobias Klauser <tklauser@distanz.ch>, dri-devel@lists.sourceforge.net,
	Hal Rosenstock <hal.rosenstock@gmail.com>,
	Len Brown <lenb@kernel.org>, linux-kbuild@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@infradead.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Amit Shah <amit.shah@redhat.com>, Daniel Mack <daniel@caiaq.de>,
	spi-devel-general@lists.sourceforge.net,
	containers@lists.linux-foundation.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Michal Sojka <sojkam1@fel.cvut.cz>,
	Christoph Lameter <cl@linux-foundation.org>, linux-pci@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Sean Hefty <sean.hefty@intel.com>,
	Sam Ravnborg <sam@ravnborg.org>, linux-rdma@vger.kernel.org,
	Matthew Wilcox <willy@linux.intel.com>,
	Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alex Chiang <achiang@hp.com>, Mel Gorman <mel@csn.ul.ie>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Jing Huang <huangj@brocade.com>, Jiri Pirko <jpirko@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Jean Delvare <khali@linux-fr.org>, Joe Perches <joe@perches.com>,
	"David S. Miller" <davem@davemloft.net>,
	jfs-discussion@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Henrik Austad <henrik@austad.us>, linux-ide@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Bernhard Schiffner <bernhard@schiffner-limbach.de>,
	linux1394-devel@lists.sourceforge.net, devel@driverdev.osuosl.org,
	Amit Kucheria <amit.kucheria@verdurent.com>,
	Douglas Schilling Landgraf <dougsland@redhat.com>,
	linux-scsi@vger.kernel.org, Yu Zhao <yu.zhao@intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
	Shirley Ma <xma@us.ibm.com>, Thomas Weber <swirl@gmx.li>,
	Steve Glendinning <steve.glendinning@smsc.com>,
	Paul Menage <menage@google.com>, Alan Cox <alan@linux.intel.com>,
	Michal Marek <mmarek@suse.cz>, Michal Simek <monstr@monstr.eu>,
	Ben Blum <bblum@andrew.cmu.edu>, netdev@vger.kernel.org,
	Akihiro Tsukada <tskd2@yahoo.co.jp>,
	Johannes Berg <johannes@sipsolutions.net>,
	Inaky Perez-Gonzalez <inaky@linux.intel.com>,
	Larry Finger <Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have fixed some typos.

Thomas Weber (4):
  Fix typo: [Ss]ytem => [Ss]ystem
  Fix typo: udpate => update
  Fix typo: paramters => parameters
  Fix typo: orginal => original

 Documentation/cgroups/cgroups.txt               |    2 +-
 Documentation/kbuild/kconfig.txt                |    2 +-
 Documentation/sysfs-rules.txt                   |    2 +-
 Documentation/trace/events.txt                  |    8 ++++----
 drivers/acpi/osl.c                              |    4 ++--
 drivers/ata/ata_piix.c                          |    2 +-
 drivers/firewire/ohci.c                         |    2 +-
 drivers/gpu/drm/drm_bufs.c                      |    2 +-
 drivers/infiniband/hw/ipath/ipath_iba6110.c     |    2 +-
 drivers/infiniband/hw/ipath/ipath_iba6120.c     |    4 ++--
 drivers/infiniband/hw/ipath/ipath_iba7220.c     |    2 +-
 drivers/isdn/hisax/hfc4s8s_l1.c                 |    2 +-
 drivers/macintosh/windfarm_pm81.c               |    2 +-
 drivers/media/dvb/dvb-usb/friio-fe.c            |    2 +-
 drivers/net/smsc911x.c                          |    4 ++--
 drivers/pci/hotplug/cpqphp_core.c               |    2 +-
 drivers/pci/pci.c                               |    2 +-
 drivers/ps3/ps3-sys-manager.c                   |    2 +-
 drivers/regulator/core.c                        |    2 +-
 drivers/s390/char/sclp_cpi_sys.c                |    2 +-
 drivers/scsi/bfa/include/defs/bfa_defs_cee.h    |    2 +-
 drivers/scsi/bfa/include/defs/bfa_defs_status.h |    4 ++--
 drivers/spi/spi_mpc8xxx.c                       |    2 +-
 drivers/staging/iio/Documentation/overview.txt  |    2 +-
 drivers/staging/rt2860/rtmp.h                   |    2 +-
 drivers/staging/rtl8187se/r8180_core.c          |    4 ++--
 drivers/staging/rtl8187se/r8180_dm.c            |    2 +-
 drivers/staging/rtl8187se/r8185b_init.c         |    2 +-
 drivers/virtio/virtio_pci.c                     |    2 +-
 fs/jfs/jfs_dmap.c                               |    2 +-
 kernel/cgroup.c                                 |    2 +-
 mm/page_alloc.c                                 |    2 +-
 net/wimax/op-rfkill.c                           |    2 +-
 sound/pci/emu10k1/emu10k1_main.c                |    2 +-
 34 files changed, 42 insertions(+), 42 deletions(-)
