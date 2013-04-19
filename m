Return-Path: <juhosg@openwrt.org>
Received: from arrakis.dune.hu (arrakis.dune.hu [78.24.191.176])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CB9BC2C0203
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2013 17:29:36 +1000 (EST)
Message-ID: <5170F016.6050502@openwrt.org>
Date: Fri, 19 Apr 2013 09:19:50 +0200
From: Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net>
In-Reply-To: <20130418130919.GI27197@titan.lakedaemon.net>
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

2013.04.18. 15:09 keltezéssel, Jason Cooper írta:
> On Thu, Apr 18, 2013 at 01:59:10PM +0100, Andrew Murray wrote:
>> On Wed, Apr 17, 2013 at 04:42:48PM +0100, Linus Walleij wrote:
>>> On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
>>>
>>>> This patch converts the pci_load_of_ranges function to use the new common
>>>> of_pci_range_parser.
>>>>
>>>> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
>>>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>>> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Jason - you may not have seen this, but here (Linus Walleij) is another Tested-by
>> to add to this patch in your tree (if you can).
> 
> Thanks, I saw it.  Unfortunately, the PR was already sent, and the branch
> is now pulled into arm-soc.

Sorry I had no time earlier, but I have tested this now on MIPS. The patch
causes build errors unfortunately. Given the fact that this has been merged
already, I will send a fixup patch.

-Gabor
