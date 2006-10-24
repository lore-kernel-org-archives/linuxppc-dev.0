Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17726.39780.732843.150044@cargo.ozlabs.ibm.com>
Date: Wed, 25 Oct 2006 09:01:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
In-Reply-To: <453E34FB.3030209@genesi-usa.com>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<453B6A84.3050209@bplan-gmbh.de>
	<1161585371.10524.444.camel@localhost.localdomain>
	<453CD615.4050401@genesi-usa.com>
	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>
	<453E34FB.3030209@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey writes:

> http://www.power.org/news/articles/new_brand/#isa
> 
> I'm talking about the one they consolidated from all the different specs
> Freescale, AMCC and IBM had about what makes a PowerPC processor. Since
> POWER is part of it and it's all Power.org now.. they seem to have changed
> the name.

So, are you proposing we drop support for all the PowerPC processors
that don't conform to the recently-published V2.03 ISA?  You don't
want 6xx, 7xx, 7xxx, 52xx, etc. supported any more? :)  (joke :)

Seriously, the v2.03 ISA covers only IBM's latest POWER processors
(i.e. not POWER3, POWER4, or even POWER5), and Book E processors.  We
support a lot more than that.

Paul.
