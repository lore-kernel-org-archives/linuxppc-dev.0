Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3028CDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 23:45:31 +1100 (EST)
Message-ID: <4729CA20.6040905@ru.mvista.com>
Date: Thu, 01 Nov 2007 15:44:16 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: tnt@blacksnow.net
Subject: Re: [PATCH 1/2] USB: Rework OHCI PPC OF for new bindings
References: <20071024163412.GA17785@ru.mvista.com>
	<471FC191.6020704@genesi-usa.com>
	<52304.213.186.37.16.1193915988.squirrel@www.opensources.be>
In-Reply-To: <52304.213.186.37.16.1193915988.squirrel@www.opensources.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

tnt@blacksnow.net wrote:
>>> USB_OHCI_BIG_ENDIAN_DESC/MMIO should always be enabled for ppc
>>> and USB_OHCI_LITTLE_ENDIAN is selected for USB_OHCI_HCD_PCI by default.
> 
> I don't find those options useless. If you think the defauts are not the
> best change them but I find these options relevant. You don't always want
> the support for BE on PPC ... if the only controller you have is pci ...
> or if you're on a soc that use little endian ...

If I have just a pci controller, and don't expect to to find/use the 
built-in one, why should I need the ohci-ppc-of driver then?
I'm not aware of a soc that uses little endian, but I think that LE/BE 
still shouldn't be selected manually. It should be autoselected then, 
the same way we select LE for PCI for example.

> 
> Do we really need to stop supporting the old values right now ?

I've resubmitted the patches with the old mpc52xx bindings support.
Keeping old ohci-be/le stuff along with the new bindings doesn't look 
good to me. However, I think we can live with the old ones and maybe 
find a better way for OF ohci support later.

> 
> IMHO, Changing to the usb-ohci with a property sounds fine to me if you
> really want to but don't drop support for the old values. They are not
> "bad". Change the dts to reflect the fact that the new "way" is preferred
> and a comment somewhere in the code and that should be fine.

OK

>     Sylvain
> 

Thanks,
Valentine.
