Return-Path: <andrew.murray@arm.com>
Date: Mon, 22 Apr 2013 11:49:16 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Gabor Juhos <juhosg@openwrt.org>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
Message-ID: <20130422104916.GA17007@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net>
 <5170F016.6050502@openwrt.org>
 <20130420223343.GB25724@titan.lakedaemon.net>
 <517394C6.2060407@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <517394C6.2060407@openwrt.org>
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
 Thomas Abraham <thomas.abraham@linaro.org>,
 Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 Kukjin Kim <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Michal Simek <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 21, 2013 at 08:27:02AM +0100, Gabor Juhos wrote:
> Hi Jason,
> 
> >> Sorry I had no time earlier, but I have tested this now on MIPS. The patch
> >> causes build errors unfortunately. Given the fact that this has been merged
> >> already, I will send a fixup patch.
> > 
> > Olof has dropped this branch from arm-soc, plase post the build error
> > and fix here so that it can be included in this series.
> 
> I have posted the patch to Olof two days ago. It has been CC'd to you as well
> but In case that it does not exists in your mailbox the patch can be found here:
> 
> https://patchwork.linux-mips.org/patch/5196/
> 
> However I can re-post the patch as a reply to this thread if you prefer that.

As this branch was dropped I have updated my patchset to include Grant's recent
feedback - I've also included Gabor's fixes to this patchset (and his sign-off).

If you include this new patchset in your branch the drivers that depend on it
will need to be updated to reflect the new naming of functions as suggested by
Grant.

Thanks,

Andrew Murray
