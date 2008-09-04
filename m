Return-Path: <benh@kernel.crashing.org>
Subject: Re: More DTS questions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080903171225.GB10979@loki.buserror.net>
References: <48BE92C0.2020205@mlbassoc.com>
	<20080903171225.GB10979@loki.buserror.net>
Content-Type: text/plain
Date: Thu, 04 Sep 2008 13:18:55 +1000
Message-Id: <1220498335.4879.42.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, Gary Thomas <gary@mlbassoc.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > The things that truly aren't clear are the various lists.
> > For example, how does "interrupt-map" and "interrupts" describe
> > how the interrupts are handled? 
> 
> It is described in this document:
> http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

And in Documentation/powerpc/booting-without-of.txt

> > I don't see any reference in the code to these names (how does a driver
> > get access to such properties?)
> 
> Look in arch/powerpc/kernel/prom_parse.c.
> 
> You'll want to change &mpc5200_pic in your interrupt-map to point to your
> FPGA interrupt controller, and change the interrupt specifiers accordingly.

Yeah, basically. You create a node for your cascaded interrupt
controller, point some interrupts at it, etc...

Ben.
