Return-Path: <andrew.murray@arm.com>
Date: Thu, 18 Apr 2013 13:59:10 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
Message-ID: <20130418125910.GA17128@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, Paul Mackerras <paulus@samba.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Jingoo Han <jg1.han@samsung.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Thomas Abraham <thomas.abraham@linaro.org>, jason@lakedaemon.net,
 Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Apr 17, 2013 at 04:42:48PM +0100, Linus Walleij wrote:
> On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
> 
> > This patch converts the pci_load_of_ranges function to use the new common
> > of_pci_range_parser.
> >
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 
> Tested-by: Linus Walleij <linus.walleij@linaro.org>

Jason - you may not have seen this, but here (Linus Walleij) is another Tested-by
to add to this patch in your tree (if you can).

Andrew Murray
