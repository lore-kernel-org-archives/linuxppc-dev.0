Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B372167AC7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 07:40:00 +1000 (EST)
In-Reply-To: <052201c549db$37e8b430$2f010a0a@foundation.com>
References: <052201c549db$37e8b430$2f010a0a@foundation.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <9380e411aa15fa62ab142301af963314@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 25 Apr 2005 16:39:56 -0500
To: "Stuart Yoder" <stuart.yoder@conformative.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PowerPC + SMP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Apr 25, 2005, at 4:10 PM, Stuart Yoder wrote:

> Hi.
> =A0
> I am trying to figure out where in the PowerPC kernel the HID1=20
> register is updated to enable bits dealing with cache coherency in an=20=

> SMP system.=A0=A0 Grepping through the arch/ppc source does not reveal=20=

> much.
> =A0
> I have=A0two 7447A processors and somewhere the ABE and SYNCBE bits in=20=

> HID1=A0need to be turned on to enable cache coherency.=A0=A0 Is =
supposed to=20
> happen in the bootloader prior to the kernel running??

The expectation is that the bootloader normally handles such things.

- kumar
