Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 23397DDF53
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 22:31:59 +1000 (EST)
Date: Thu, 18 Sep 2008 14:31:46 +0200
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: Christoph Raisch <RAISCH@de.ibm.com>
Subject: Re: [PATCH HACK] powerpc: quick hack to get a functional eHEA with
	hardirq preemption, eHCA is close
Message-ID: <20080918143146.77db81d5@bull.net>
In-Reply-To: <OFD7842B7A.ADC47EED-ONC12574C8.003A2CB3-C12574C8.003AC948@de.ibm.com>
References: <20080915100406.342e027a@bull.net>
	<OF39C3BF0F.17B60FAA-ONC12574C8.002AE138-C12574C8.002B6422@de.ibm.com>
	<20080918112713.75872c95@bull.net>
	<OFD7842B7A.ADC47EED-ONC12574C8.003A2CB3-C12574C8.003AC948@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Thomas Q Klein <TKLEIN@de.ibm.com>, tinytim@us.ibm.com,
	Linux-rt <linux-rt-users@vger.kernel.org>,
	Jan-Bernd Themann <THEMANN@de.ibm.com>, netdev@vger.kernel.org,
	jean-pierre.dion@bull.net, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <bherren@au1.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 18 Sep 2008 12:42:05 +0200 Christoph Raisch <RAISCH@de.ibm.com> wrote:

> 
> Sebastien Dugue <sebastien.dugue@bull.net> wrote on 18.09.2008 11:27:13:
> 
> >
> >   It would be really interresting to know if the eHCA exhibits the same
> > problem under -rt as it's the only other user of the ibmebus.
> > Unfortunately I don't have the hardware to test.
> >
> 
> eHCA is very close from the interrupt generation and handling perspective,
> so yes, could be an issue there as well.

  That's what I was speculating.

  Thanks,

  Sebastien.

> 
> 
> Gruss / Regards
> Christoph Raisch
> 
> 
> 
