Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9764467A64
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2005 22:45:05 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jerome Glisse <j.glisse@gmail.com>
In-Reply-To: <4240b916050404033230db0551@mail.gmail.com>
References: <4240b916050404033230db0551@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 22:41:48 +1000
Message-Id: <1112618509.26086.68.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: linux 2.6.12-rc1-bk5 compilation error
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-04 at 11:32 +0100, Jerome Glisse wrote:
> Hi,
> 
> Once again i face an error that i got with a previous
> 2.6 kernel (i already posted about this in january
> i think).
> 
> My config G5 bi 2Ghz and you can grab my kernel
> config here : http://dj.planet-d.net/config
> 
> When compiling  2.6.12-rc1-bk5 i first get unknown
> symbol _flush_disable_L1. This is in arch/ppc/kernel/l2cr.S
> I changed the makefile in arch/ppc/kernel to have this :
> obj-$(CONFIG_POWER4) += cpu_setup_power4.o
> into :
> obj-$(CONFIG_POWER4) += l2cr.o cpu_setup_power4.o
>
> .../...

You should really be using a 64 bits kernel :)

Ben.
