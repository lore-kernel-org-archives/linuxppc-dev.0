Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 215462C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 22:42:14 +1000 (EST)
Received: by mail-ob0-f175.google.com with SMTP id xn12so4103823obc.20
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 05:42:11 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20130725175720.6006.96448.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
 <20130725175720.6006.96448.stgit@bhelgaas-glaptop>
Date: Fri, 26 Jul 2013 05:42:11 -0700
Message-ID: <CAE9FiQVNYB7z7e1s=1PGsgQe_kexy+7V10WAxkReA-kiQ=10yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: hotplug: Convert to be builtin only, not modular
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
> Convert CONFIG_HOTPLUG_PCI from tristate to bool.  This only affects
> the hotplug core; several of the hotplug drivers can still be modules.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/ia64/configs/generic_defconfig    |    2 +-
>  arch/ia64/configs/gensparse_defconfig  |    2 +-
>  arch/ia64/configs/tiger_defconfig      |    2 +-
>  arch/ia64/configs/xen_domu_defconfig   |    2 +-
>  arch/powerpc/configs/ppc64_defconfig   |    2 +-
>  arch/powerpc/configs/ppc64e_defconfig  |    2 +-
>  arch/powerpc/configs/pseries_defconfig |    2 +-
>  arch/sh/configs/sh03_defconfig         |    2 +-
>  drivers/pci/hotplug/Kconfig            |    5 +----
>  9 files changed, 9 insertions(+), 12 deletions(-)

Acked-by: Yinghai Lu <yinghai@kernel.org>
