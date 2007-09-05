Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id B2646DDFEC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 06:20:30 +1000 (EST)
Subject: Re: Xilinx FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: temerkhanov@yandex.ru
In-Reply-To: <200709052342.34177.temerkhanov@yandex.ru>
References: <1189017748.6185.49.camel@PisteOff>
	<200709052342.34177.temerkhanov@yandex.ru>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 14:20:28 -0600
Message-Id: <1189023628.6185.59.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-05 at 23:42 +0400, Sergey Temerkhanov wrote:
> On Wednesday 05 September 2007 22:42:28 Robert Woodworth wrote:
> > After achieving complete success with my Linux kernel on the ML403, I've
> > now started to build a kernel for my real target board with a
> > Virtex4-FX60 (dual PPC cores)
> >
> > Has anyone built a kernel for a dual core PPC Virtex?  I have found very
> > little docs on how to architect software for the dual-core PPC's.
> > Will SMP Linux work on this platform?  What would the bus setup be?
> 
> It won't. There is no hardware cache coherency on Virtex.
> 
> 

Is it then possible to run two independent kernels, one on each PPC??



> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
