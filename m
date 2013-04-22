Return-Path: <jason@lakedaemon.net>
Date: Mon, 22 Apr 2013 19:02:51 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Murray <Andrew.Murray@arm.com>
Subject: Re: [PATCH v8 0/3] of/pci: Provide common support for PCI DT parsing
Message-ID: <20130422230251.GL25724@titan.lakedaemon.net>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
 <20130422165343.GE25724@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130422165343.GE25724@titan.lakedaemon.net>
Cc: linux-mips@linux-mips.org, siva.kallam@samsung.com,
 linux-pci@vger.kernel.org, linus.walleij@linaro.org,
 thierry.reding@avionic-design.de, Liviu.Dudau@arm.com, juhosg@openwrt.org,
 paulus@samba.org, linux-samsung-soc@vger.kernel.org, linux@arm.linux.org.uk,
 jg1.han@samsung.com, jgunthorpe@obsidianresearch.com,
 thomas.abraham@linaro.org, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org,
 rob.herring@calxeda.com, kgene.kim@samsung.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, suren.reddy@samsung.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 22, 2013 at 12:53:43PM -0400, Jason Cooper wrote:
> On Mon, Apr 22, 2013 at 11:41:32AM +0100, Andrew Murray wrote:
> > This patchset factors out duplicated code associated with parsing PCI
> > DT "ranges" properties across the architectures and introduces a
> > "ranges" parser. This parser "of_pci_range_parser" can be used directly
> > by ARM host bridge drivers enabling them to obtain ranges from device
> > trees.
> > 
> > I've included the Reviewed-by, Tested-by and Acked-by's received from v5/v6/v7
> > in this patchset, earlier versions of this patchset (v3) have been tested-by:
> > 
> > Thierry Reding <thierry.reding@avionic-design.de>
> > Jingoo Han <jg1.han@samsung.com>
> > 
> > I've tested that this patchset builds and runs on ARM and that it builds on
> > PowerPC, x86_64 and MIPS.
> 
> Andrew,
> 
> Unfortunately, the mvebu/drivers branch containing your series had to be
> dropped from arm-soc for v3.10.  This was not due to your series, but
> since arm-soc's granularity is branches, your series was caught in the
> drop.
> 
> As the mvebu-pcie driver is now v3.11 material, I have taken the
> opportunity to upgrade from your v7 patchset to v8.  You can find the
> whole branch at mvebu-next/pcie.
> 
> mvebu-next/pcie *will* be rebased onto v3.9 once it drops.  Several
> dependencies will be removed (since they will have been merged into
> v3.9).

s/v3.9/v3.10-rc1/g  :)

> Once the rebase is done, I'll send a pull request to Arnd and Olof so we
> can get as many cycles on -next as possible.

thx,

Jason.
