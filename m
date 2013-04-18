Return-Path: <andrew.murray@arm.com>
Date: Thu, 18 Apr 2013 15:26:35 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
Message-ID: <20130418142635.GB18881@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <20130418134535.5189E3E1319@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130418134535.5189E3E1319@localhost>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "siva.kallam@samsung.com" <siva.kallam@samsung.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
 Liviu Dudau <Liviu.Dudau@arm.com>, "paulus@samba.org" <paulus@samba.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 "jg1.han@samsung.com" <jg1.han@samsung.com>,
 "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
 "thomas.abraham@linaro.org" <thomas.abraham@linaro.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "thomas.petazzoni@free-electrons.com" <thomas.petazzoni@free-electrons.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "suren.reddy@samsung.com" <suren.reddy@samsung.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 18, 2013 at 02:45:35PM +0100, Grant Likely wrote:
> On Tue, 16 Apr 2013 11:18:28 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> > This patch converts the pci_load_of_ranges function to use the new common
> > of_pci_range_parser.
> > 
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 
> Looks okay to me, and thank you very much for doing the legwork to merge
> the common code.

No problem, though I think there is more than can be done in this area -
there is a lot of similar PCI code floating about.

> 
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>

Thanks for the review.

Andrew Murray
