Return-Path: <tmarri@apm.com>
Received: from exprod5og108.obsmtp.com (exprod5og108.obsmtp.com [64.18.0.186])
 by ozlabs.org (Postfix) with SMTP id 618F4B6F6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 09:51:42 +1100 (EST)
Received: by iadx2 with SMTP id x2so124236iad.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 15:51:40 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1317954673-12032-1-git-send-email-tmarri@apm.com>
 <4E8EDD75.5090107@ru.mvista.com>
In-Reply-To: <4E8EDD75.5090107@ru.mvista.com>
MIME-Version: 1.0
Date: Tue, 11 Oct 2011 15:43:49 -0700
Message-ID: <85bdbe5686e64bd0be07b07e2bb9a0ac@mail.gmail.com>
Subject: RE: [PATCH v14 10/10] USB/ppc4xx:Synopsys DWC OTG driver enable
 gadget support
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<> +# dwc_otg builds in ../dwc along with host support
<> +config USB_GADGET_DWC_HDRC
<> +	boolean "DesignWare USB Peripheral"
<> +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
<> +	select USB_GADGET_DUALSPEED
<> +	select USB_GADGET_SELECTED
<> +	select USB_GADGET_DWC_OTG
<
<    I don't see where this one is defined...
<
[Tirumala Marri] You mean USB_GADGET_SELECTED ? Ok I will add it.
--marri
