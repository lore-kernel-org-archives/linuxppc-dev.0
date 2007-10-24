Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31E04DDF21
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 02:30:55 +1000 (EST)
Date: Wed, 24 Oct 2007 20:22:23 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] USB: Rework OHCI PPC OF driver to support new bindings
Message-ID: <20071024162223.GA17649@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tnt@246tNt.com, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These patches update ohci-ppc-of and the dts files for the new bindings.
The "compatible" is set to "usb-ohci" and the "big-endian" quirkiness is 
expressed by a property, not by the "compatible" name.
Also user-selectable USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE config
options are removed, since the USB_OHCI_BIG_ENDIAN/USB_OHCI_LITTLE_ENDIAN
selection is made by default for PPC/PCI OHCI controllers.
