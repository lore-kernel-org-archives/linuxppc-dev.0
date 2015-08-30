Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFD631A028B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:44 +1000 (AEST)
In-Reply-To: <1440648757-23359-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [2/2] powerpc/pseries: Cleanup on pci_dn_reconfig_notifier()
Message-Id: <20150830212044.59E0E140295@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:44 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 04:12:37 UTC, Gavin Shan wrote:
> This applies cleanup on pci_dn_reconfig_notifier(), no functional
> changes:
> 
>    * Rename variable "pci" to "pdn" to indicate its purpose clearly.
>    * The parent node can be released at any time. So it should be
>      hold with of_get_parent() before accessing it.
>    * The device node doesn't have to have parent node in theory.
>      More check on this.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ea0f8acf4d44727f7d3a3807

cheers
