Return-Path: <linus.walleij@linaro.org>
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com
 [IPv6:2607:f8b0:4001:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9C092C016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 01:42:52 +1000 (EST)
Received: by mail-ie0-f179.google.com with SMTP id 16so2049108iea.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2013 08:42:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
Date: Wed, 17 Apr 2013 17:42:48 +0200
Message-ID: <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
From: Linus Walleij <linus.walleij@linaro.org>
To: Andrew Murray <Andrew.Murray@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, siva.kallam@samsung.com,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>,
 Liviu.Dudau@arm.com, Paul Mackerras <paulus@samba.org>,
 linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Jingoo Han <jg1.han@samsung.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Thomas Abraham <thomas.abraham@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 Rob Herring <rob.herring@calxeda.com>, Kukjin Kim <kgene.kim@samsung.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Michal Simek <monstr@monstr.eu>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 suren.reddy@samsung.com,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:

> This patch converts the pci_load_of_ranges function to use the new common
> of_pci_range_parser.
>
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
