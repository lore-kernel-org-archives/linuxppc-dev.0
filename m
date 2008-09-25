Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id A0CA0DDF4A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 18:39:13 +1000 (EST)
Date: Thu, 25 Sep 2008 10:39:03 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption
Message-ID: <20080925103903.3581226f@bull.net>
In-Reply-To: <1222331779.8277.183.camel@pasglop>
References: <200809231743.23828.ossthema@de.ibm.com>
	<20080915100406.342e027a@bull.net>
	<200809240958.m8O9wM7k010996@sullivan.realtime.net>
	<1222251467.8277.73.camel@pasglop>
	<20080924143552.29a14f10@bull.net>
	<1222290917.8277.83.camel@pasglop>
	<20080925091827.29b5087c@bull.net>
	<1222327361.8277.179.camel@pasglop>
	<20080925094231.442a4c75@bull.net>
	<1222331779.8277.183.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Jan-Bernd Themann <ossthema@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 25 Sep 2008 18:36:19 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> >   Do you mean creating a custom fasteoi handler into xics.c? Also, it's
> > not clear to me from looking at the code how you go about changing the
> > cpu priority.
> 
> Yup. I think the priority is the CPPR.. Milton can give you more
> details, if not, I'll pick it up tomorrow when at the office.
> 

  Thanks Ben, will look into this.

  Nite

  Sebastien.
