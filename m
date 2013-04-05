Return-Path: <michael@ellerman.id.au>
Date: Fri, 5 Apr 2013 17:55:33 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] pci: Export pci_dev_type
Message-ID: <20130405065533.GD5082@concordia>
References: <201304042158.r34LwDHx010466@d03av02.boulder.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201304042158.r34LwDHx010466@d03av02.boulder.ibm.com>
Cc: klebers@linux.vnet.ibm.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 linuxppc-dev@lists.ozlabs.org, lucaskt@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bjorn,

Should we take this series via the powerpc tree, assuming you're OK with
this patch?

cheers

On Thu, Apr 04, 2013 at 04:58:13PM -0500, Brian King wrote:
> 
> Export pci_dev_type so that arch specific PCI probing code can
> initialize a new PCI device struct.
> 
> Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
> ---
> 
>  drivers/pci/pci.h   |    1 -
>  include/linux/pci.h |    1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/pci/pci.h~pci_export_pci_dev_type drivers/pci/pci.h
> --- linux/drivers/pci/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:25.000000000 -0500
> +++ linux-bjking1/drivers/pci/pci.h	2013-04-02 17:02:31.000000000 -0500
> @@ -153,7 +153,6 @@ static inline int pci_no_d1d2(struct pci
>  }
>  extern struct device_attribute pci_dev_attrs[];
>  extern struct device_attribute pcibus_dev_attrs[];
> -extern struct device_type pci_dev_type;
>  extern struct bus_attribute pci_bus_attrs[];
>  
>  
> diff -puN include/linux/pci.h~pci_export_pci_dev_type include/linux/pci.h
> --- linux/include/linux/pci.h~pci_export_pci_dev_type	2013-04-02 17:01:59.000000000 -0500
> +++ linux-bjking1/include/linux/pci.h	2013-04-02 17:02:29.000000000 -0500
> @@ -670,6 +670,7 @@ enum pcie_bus_config_types {
>  extern enum pcie_bus_config_types pcie_bus_config;
>  
>  extern struct bus_type pci_bus_type;
> +extern struct device_type pci_dev_type;
>  
>  /* Do NOT directly access these two variables, unless you are arch specific pci
>   * code, or pci core code. */
> _
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
