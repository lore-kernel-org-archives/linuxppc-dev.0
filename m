Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A16932C034E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 12:11:44 +1000 (EST)
Message-ID: <1372385489.18612.52.camel@pasglop>
Subject: Re: [PATCH] powerpc/eeh: Update MAINTAINERS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Fri, 28 Jun 2013 12:11:29 +1000
In-Reply-To: <1372384784-20788-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372384784-20788-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linas Vepstas <linasvepstas@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-28 at 09:59 +0800, Gavin Shan wrote:
> Update MAINTAINERS to reflect recent changes.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  MAINTAINERS |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5be702c..b447392 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6146,10 +6146,14 @@ F:	drivers/firmware/pcdp.*
>  
>  PCI ERROR RECOVERY
>  M:	 
> +M:	Gavin Shan <shangw@linux.vnet.ibm.com>

Remove Linas, he isn't involved anymore as far as I can tell
(are you ?)

>  L:	linux-pci@vger.kernel.org
> +L:	linuxppc-dev@lists.ozlabs.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.txt
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> +F:	arch/powerpc/kernel/eeh*.c
> +F:	drivers/pci/pcie/aer/

Not sure about the AER code. You are not maintaining *that* at least :-)
Maybe we should split EEH from the rest ?

Cheers,
Ben.

>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
