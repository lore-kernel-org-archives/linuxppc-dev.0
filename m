Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D74E9DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 18:58:29 +1000 (EST)
Message-ID: <469B336A.5060303@genesi-usa.com>
Date: Mon, 16 Jul 2007 09:59:22 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Legacy ISA registers/interrupts in PCI device tree node
References: <20070716075317.15260@gmx.net>
In-Reply-To: <20070716075317.15260@gmx.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gerhard,

You could do a LOT worse than check the Pegasos.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Gerhard Pircher wrote:
> Hi,
> 
> I wonder, if there is a recommended way to specify ISA register addresses
> and interrupts for a PCI device (unlike for a PCI2ISA bridge)?
> The device in question is the integrated IDE controller of the VIA686B
> southbridge, which works in compatible/legacy mode and thus uses interrupts
> 14 and 15 of the i8259 PIC. Should the fdt contain this information or
> should I hardcode the values in the platform setup code?
> 
> Thanks!
> 
> Regards,
> 
> Gerhard
