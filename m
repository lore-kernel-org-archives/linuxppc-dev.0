Return-Path: <juhosg@openwrt.org>
Message-ID: <517394C6.2060407@openwrt.org>
Date: Sun, 21 Apr 2013 09:27:02 +0200
From: Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net> <5170F016.6050502@openwrt.org>
 <20130420223343.GB25724@titan.lakedaemon.net>
In-Reply-To: <20130420223343.GB25724@titan.lakedaemon.net>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Jason,

>> Sorry I had no time earlier, but I have tested this now on MIPS. The patch
>> causes build errors unfortunately. Given the fact that this has been merged
>> already, I will send a fixup patch.
> 
> Olof has dropped this branch from arm-soc, plase post the build error
> and fix here so that it can be included in this series.

I have posted the patch to Olof two days ago. It has been CC'd to you as well
but In case that it does not exists in your mailbox the patch can be found here:

https://patchwork.linux-mips.org/patch/5196/

However I can re-post the patch as a reply to this thread if you prefer that.

-Gabor
