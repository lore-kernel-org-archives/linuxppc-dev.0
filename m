Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF720DE2FC
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 13:48:21 +1100 (EST)
Date: Fri, 11 Jan 2008 13:02:16 -0600
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Device Tree & PCI
Message-ID: <20080111190215.GA10857@loki.buserror.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D9A381@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 11, 2008 at 12:17:41PM -0600, Rune Torgersen wrote:
> 		PCI_INT: pic@5,10 {
> 			#interrupt-cells = <1>;
> 			interrupt-controller;
> 			reg = <5 10 4>;                             //
> Chip select, offset, length
> 			compatible = "apmax-pciintmux";
> 			interrupt-parent = <&PIC>;
> 			interrupts = <19 8>;                        //
> IRQ7, interrupt#25
> 		};

Is this interrupt controller getting registered before the PCI bus gets
probed?

-Scott
