Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82CB1DE0E8
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:41:01 +1000 (EST)
In-Reply-To: <20070716075317.15260@gmx.net>
References: <20070716075317.15260@gmx.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D0634B84-BD83-460E-AEC2-E8BB2837B237@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Legacy ISA registers/interrupts in PCI device tree node
Date: Mon, 16 Jul 2007 14:40:48 +0200
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I wonder, if there is a recommended way to specify ISA register  
> addresses
> and interrupts for a PCI device (unlike for a PCI2ISA bridge)?

The PCI binding describes the required way to do this.

> The device in question is the integrated IDE controller of the VIA686B
> southbridge, which works in compatible/legacy mode and thus uses  
> interrupts
> 14 and 15 of the i8259 PIC. Should the fdt contain this information

Yes, it should, even if you don't use this in the Linux
kernel yet.

> or should I hardcode the values in the platform setup code?

No.


Segher
