Return-Path: <jason@lakedaemon.net>
Date: Sat, 20 Apr 2013 18:33:43 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
Message-ID: <20130420223343.GB25724@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net>
 <5170F016.6050502@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <5170F016.6050502@openwrt.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, Paul Mackerras <paulus@samba.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Jingoo Han <jg1.han@samsung.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Thomas Abraham <thomas.abraham@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Kukjin Kim <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Michal Simek <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 Andrew Murray <andrew.murray@arm.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 19, 2013 at 09:19:50AM +0200, Gabor Juhos wrote:
> 2013.04.18. 15:09 keltez=E9ssel, Jason Cooper =EDrta:
> > On Thu, Apr 18, 2013 at 01:59:10PM +0100, Andrew Murray wrote:
> >> On Wed, Apr 17, 2013 at 04:42:48PM +0100, Linus Walleij wrote:
> >>> On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.=
com> wrote:
> >>>
> >>>> This patch converts the pci_load_of_ranges function to use the new=
 common
> >>>> of_pci_range_parser.
> >>>>
> >>>> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> >>>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >>>> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> >>>
> >>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >>
> >> Jason - you may not have seen this, but here (Linus Walleij) is anot=
her Tested-by
> >> to add to this patch in your tree (if you can).
> >=20
> > Thanks, I saw it.  Unfortunately, the PR was already sent, and the br=
anch
> > is now pulled into arm-soc.
>=20
> Sorry I had no time earlier, but I have tested this now on MIPS. The pa=
tch
> causes build errors unfortunately. Given the fact that this has been me=
rged
> already, I will send a fixup patch.

Olof has dropped this branch from arm-soc, plase post the build error
and fix here so that it can be included in this series.

thx,

Jason.
