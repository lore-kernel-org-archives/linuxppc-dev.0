Return-Path: <grant.likely@secretlab.ca>
Received: from mail-wi0-x22e.google.com (mail-wi0-x22e.google.com
 [IPv6:2a00:1450:400c:c05::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E93962C0171
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 23:45:42 +1000 (EST)
Received: by mail-wi0-f174.google.com with SMTP id m6so4102927wiv.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 06:45:38 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
To: Andrew Murray <Andrew.Murray@arm.com>, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
Date: Thu, 18 Apr 2013 14:45:35 +0100
Message-Id: <20130418134535.5189E3E1319@localhost>
Cc: siva.kallam@samsung.com, linux-pci@vger.kernel.org,
 linus.walleij@linaro.org, thierry.reding@avionic-design.de,
 Liviu.Dudau@arm.com, paulus@samba.org, linux-samsung-soc@vger.kernel.org,
 linux@arm.linux.org.uk, jg1.han@samsung.com, jgunthorpe@obsidianresearch.com,
 thomas.abraham@linaro.org, arnd@arndb.de, devicetree-discuss@lists.ozlabs.org,
 rob.herring@calxeda.com, kgene.kim@samsung.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com,
 monstr@monstr.eu, linux-kernel@vger.kernel.org, suren.reddy@samsung.com,
 Andrew Murray <Andrew.Murray@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Apr 2013 11:18:28 +0100, Andrew Murray <Andrew.Murray@arm.com> wrote:
> This patch converts the pci_load_of_ranges function to use the new common
> of_pci_range_parser.
> 
> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>

Looks okay to me, and thank you very much for doing the legwork to merge
the common code.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
