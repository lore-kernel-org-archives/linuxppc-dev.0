Return-Path: <tnt@blacksnow.net>
Received: from leia.blacksnow.net (leia.blacksnow.net [213.251.174.139])
	by ozlabs.org (Postfix) with ESMTP id C912FDDDEB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 23:20:28 +1100 (EST)
Message-ID: <52304.213.186.37.16.1193915988.squirrel@www.opensources.be>
In-Reply-To: <471FC191.6020704@genesi-usa.com>
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
Date: Thu, 1 Nov 2007 12:19:48 +0100 (CET)
Subject: Re: [PATCH 1/2] USB: Rework OHCI PPC OF for new bindings
From: tnt@blacksnow.net
To: "Matt Sealey" <matt@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Valentine Barshak wrote:
>> Rework ohci-ppc-of driver to use big-endian property instead of
>> ohci-be/ohci-le compatible strings. Also remove unnecessary
>> user-selectable USB_OHCI_HCD_PPC_OF_LE/BE stuff, because
>> USB_OHCI_BIG_ENDIAN_DESC/MMIO should always be enabled for ppc
>> and USB_OHCI_LITTLE_ENDIAN is selected for USB_OHCI_HCD_PCI by default.

I don't find those options useless. If you think the defauts are not the
best change them but I find these options relevant. You don't always want
the support for BE on PPC ... if the only controller you have is pci ...
or if you're on a soc that use little endian ...


> Can we just make sure real quickly that the changing of compatibles
> doesn't break existing, not-easily-flashable firmwares?

I tend to agree with Matt here.

Do we really need to stop supporting the old values right now ?

IMHO, Changing to the usb-ohci with a property sounds fine to me if you
really want to but don't drop support for the old values. They are not
"bad". Change the dts to reflect the fact that the new "way" is preferred
and a comment somewhere in the code and that should be fine.



    Sylvain
