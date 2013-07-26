Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ob0-x231.google.com (mail-ob0-x231.google.com
 [IPv6:2607:f8b0:4003:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D521A2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 22:43:40 +1000 (EST)
Received: by mail-ob0-f177.google.com with SMTP id ta17so4133691obb.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 05:43:36 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
 <20130725175727.6006.98109.stgit@bhelgaas-glaptop>
Date: Fri, 26 Jul 2013 05:43:36 -0700
Message-ID: <CAE9FiQU9k6m-5bM5ZfFUZxW3H7_v4aOtaK66pa7iV0Zb-J86jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Convert pciehp to be builtin only,
 not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-sh@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 25, 2013 at 10:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert pciehp to be builtin only, with no module option.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pcie/Kconfig |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 569f82f..3b94cfc 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>  # Include service Kconfig here
>  #
>  config HOTPLUG_PCI_PCIE
> -       tristate "PCI Express Hotplug driver"
> +       bool "PCI Express Hotplug driver"
>         depends on HOTPLUG_PCI && PCIEPORTBUS
>         help
>           Say Y here if you have a motherboard that supports PCI Express Native
>           Hotplug
>
> -         To compile this driver as a module, choose M here: the
> -         module will be called pciehp.
> -
>           When in doubt, say N.
>
>  source "drivers/pci/pcie/aer/Kconfig"
>

Acked-by: Yinghai Lu <yinghai@kernel.org>
