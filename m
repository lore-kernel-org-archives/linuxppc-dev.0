Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qlgjw5lQyzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 09:58:28 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, devicetree@vger.kernel.org,
 grant.likely@linaro.org, robherring2@gmail.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, dja@axtens.net
Subject: Re: [PATCH v8 00/45] powerpc/powernv: PCI hotplug support
Date: Thu, 14 Apr 2016 09:57:32 +1000
Message-ID: <8771729.bnzLL9sLJY@new-mexico>
In-Reply-To: <20160413234246.GA5330@gwshan>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <570E0E13.6080409@ozlabs.ru> <20160413234246.GA5330@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gavin,

<snip>

> >Why exactly cannot EEH reset changes go to a smaller separate patchset
> >(before hotplug)?
> >
> 
> As I explained before, the patchset's order is: PCI generic part,
> PowerNV PCI related, EEH related, device-tree part and hotplug driver.
> 
> The EEH reset change is included in PATCH[37/45]. There is no point
> to reorder the patches.
 
I don't understand all of the dependencies but if possible splitting the 
series up into a set of smaller self-contained patch series makes things 
easier to review and may make it easier for you to get this functionality 
reviewed and accepted into upstream.

Regards,

Alistair
