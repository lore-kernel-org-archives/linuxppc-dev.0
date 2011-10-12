Return-Path: <sshtylyov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
 by ozlabs.org (Postfix) with SMTP id AA6ABB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 22:17:28 +1100 (EST)
Message-ID: <4E957712.8050400@ru.mvista.com>
Date: Wed, 12 Oct 2011 15:16:34 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH v14 10/10] USB/ppc4xx:Synopsys DWC OTG driver enable gadget
 support
References: <1317954673-12032-1-git-send-email-tmarri@apm.com>
 <4E8EDD75.5090107@ru.mvista.com>
 <85bdbe5686e64bd0be07b07e2bb9a0ac@mail.gmail.com>
In-Reply-To: <85bdbe5686e64bd0be07b07e2bb9a0ac@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello.

On 12-10-2011 2:43, Tirumala Marri wrote:

> <>  +# dwc_otg builds in ../dwc along with host support
> <>  +config USB_GADGET_DWC_HDRC
> <>  +	boolean "DesignWare USB Peripheral"
> <>  +	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
> <>  +	select USB_GADGET_DUALSPEED
> <>  +	select USB_GADGET_SELECTED
> <>  +	select USB_GADGET_DWC_OTG

> <     I don't see where this one is defined...

> [Tirumala Marri] You mean USB_GADGET_SELECTED ? Ok I will add it.

    No, I mean USB_GADGET_DWC_OTG. USB_GADGET_SELECTED is already defined.

> --marri

WBR, Sergei
