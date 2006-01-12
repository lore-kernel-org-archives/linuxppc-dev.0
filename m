Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6FC568A34
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jan 2006 15:44:40 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_stamer@gmx.net>
In-Reply-To: <6063.1137013232@www88.gmx.net>
References: <6063.1137013232@www88.gmx.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 15:44:27 +1100
Message-Id: <1137041067.7774.25.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: AGPGART driver for ArticiaS - ioremap() problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-01-11 at 22:00 +0100, Gerhard Pircher wrote:
> Hi,
> 
> David Bentam and I are trying to get a AGPGART driver working for the
> AmigaOne and the Pegasos1. The driver detects the aperture size of the
> ArticiaS AGP bridge, but fails at the ioremap() function in the generic GATT
> table create function. Does the PowerPC platform behaves differently for the
> mapping of address location for AGP operation than the x86 platform? Is it
> possible to use a mask to relocate the AGP address space to a specific
> location?

Well, what value are you passing to ioremap ?

Ben.
