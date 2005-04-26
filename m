Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DA03067B25
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 13:36:49 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stuart Yoder <stuart.yoder@conformative.com>
In-Reply-To: <052701c549db$4fb20760$2f010a0a@foundation.com>
References: <052701c549db$4fb20760$2f010a0a@foundation.com>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:36:34 +1000
Message-Id: <1114486594.7183.12.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: PowerPC + SMP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-25 at 16:11 -0500, Stuart Yoder wrote:
> Hi.
>  
> I am trying to figure out where in the PowerPC kernel the HID1
> register is updated to enable bits dealing with cache coherency in an
> SMP system.   Grepping through the arch/ppc source does not reveal
> much.
>  
> I have two 7447A processors and somewhere the ABE and SYNCBE bits need
> to be turned on to enable cache coherency.   Is supposed to happen in
> the bootloader prior to the kernel running??

It's usually expected to happen in the firmware yes, though the kernel
does some of it's own 'fixups' (look at setup_cpu_6xx.S)

Ben.
