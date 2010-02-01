Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:26:53 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Reduce footprint of xics_ipi_struct
Message-ID: <20100201062653.GS2996@kryten>
References: <20100112105642.GI12666@kryten> <20100112105805.GJ12666@kryten>
	<1265001510.8287.30.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1265001510.8287.30.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> > +#if defined(CONFIG_XICS) && defined(CONFIG_SMP)
> > +	unsigned long xics_ipi;
> > +#endif
> >  } ____cacheline_aligned irq_cpustat_t;
> 
> This is still a gross abuse of irq_cpustat_t ... Can't we do
> a separate DECLARE_PER_CPU_SHARED_ALIGNED(unsigned long, xics_ipi)
> inside xics.c instead ?

Yeah it was a bit tasteless :) Respinning...

Anton
