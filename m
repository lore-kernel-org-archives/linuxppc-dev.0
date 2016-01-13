Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7F8B1A028D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 08:18:13 +1100 (AEDT)
Message-ID: <1452719886.8203.1.camel@ellerman.id.au>
Subject: Re: [v7,49/50] drivers/of: Export OF changeset functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, frowand.list@gmail.com, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, panto@antoniou-consulting.com,
 bhelgaas@google.com,  robherring2@gmail.com, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org
Date: Thu, 14 Jan 2016 08:18:06 +1100
In-Reply-To: <20160113135426.GA29030@katana>
References: <1446642770-4681-50-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160113135426.GA29030@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-13 at 14:54 +0100, Wolfram Sang wrote:
> On Thu, Nov 05, 2015 at 12:12:49AM +1100, Gavin Shan wrote:
> > The PowerNV PCI hotplug driver is going to use the OF changeset
> > to manage the changed device sub-tree. This exports those OF
> > changeset functions for that.
> > 
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> I needed something like this, too [1] and rebased my series on top of
> this patch. So:
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

OK. This series is kind of in limbo, it might hit 4.6, but it might not. So if
you need this patch before then you should probably pull it in to your series,
or ask Rob to merge it pre-emptively.

cheers
