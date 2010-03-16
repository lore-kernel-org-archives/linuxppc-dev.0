Return-Path: <jkosina@suse.cz>
Date: Tue, 16 Mar 2010 11:32:24 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/4] Some typo fixing
In-Reply-To: <4B9EA214.7010203@xenotime.net>
Message-ID: <alpine.LNX.2.00.1003161127340.18642@pobox.suse.cz>
References: <1268686558-28171-1-git-send-email-swirl@gmx.li>
	<4B9EA214.7010203@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
	linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-media@vger.kernel.org, Pieter Palmers <pieterp@joow.be>,
	Anand Gadiyar <gadiyar@ti.com>, alsa-devel@alsa-project.org,
	linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Clemens Ladisch <clemens@ladisch.de>, linux-mm@kvack.org,
	"James E.J. Bottomley" <James.Bottomley@suse.de>,
	=?ISO-8859-15?Q?H=E5kan_Johansson?= <f96hajo@chalmers.se>,
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
	Jean Delvare <khali@linux-fr.org>, Tejun Heo <tj@kernel.org>,
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
	=?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
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

On Mon, 15 Mar 2010, Randy Dunlap wrote:

> > I have fixed some typos.
> 
> Acked-by: Randy Dunlap <rdunlap@xenotime.net>
> 
> Jiri, can you merge these, please, unless someone objects (?).

Yes, I will take it, thanks. A couple comments though:

- [important!] Thomas, it's not necessary to CC zillions of people on such 
  patches. Just submit them to trivial@kernel.org (and eventually CC 
  lkml), and that's it. I believe many people might get annoyed by this.
- I will not be applying the drivers/staging hunks. Staging patches are 
  moving target, the code is changing quickly (including complete 
  drops/rewrites) so we'll likely be getting conflicts there. I will 
  reroute them to Greg.
- I will fold all the patches into one. We don't need one commit per one 
  specific typo.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
