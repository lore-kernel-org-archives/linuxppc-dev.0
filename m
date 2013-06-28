Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 28C2F2C0366
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 14:57:04 +1000 (EST)
Message-ID: <1372395413.18612.58.camel@pasglop>
Subject: Re: [PATCH v2] powerpc/eeh: Update MAINTAINERS
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Fri, 28 Jun 2013 14:56:53 +1000
In-Reply-To: <1372386316-24086-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372386316-24086-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-28 at 10:25 +0800, Gavin Shan wrote:
> Update MAINTAINERS to reflect recent changes.
> 
> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  MAINTAINERS |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5be702c..c724a3a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6149,7 +6149,14 @@ M:	Linas Vepstas <linasvepstas@gmail.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.txt
> +F:	drivers/pci/pcie/aer/

Almost ;-) I still don't think that Linus has anything to do with AER,
just don't add the above line.

> +ENHANCED ERROR HANDLING (EEH)
> +M:	Gavin Shan <shangw@linux.vnet.ibm.com>
> +L:	linuxppc-dev@lists.ozlabs.org
> +S:	Supported
>  F:	Documentation/powerpc/eeh-pci-error-recovery.txt
> +F:	arch/powerpc/kernel/eeh*.c
>  
>  PCI SUBSYSTEM
>  M:	Bjorn Helgaas <bhelgaas@google.com>
