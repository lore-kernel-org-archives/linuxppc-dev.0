Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2890667A5C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:02:03 +1000 (EST)
Date: Thu, 20 Apr 2006 14:02:01 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420210201.GA25755@gate.ebshome.net>
References: <20060420203848.GA23192@gate.ebshome.net>
	<12655.1145566593@www088.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12655.1145566593@www088.gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2006 at 10:56:33PM +0200, Gerhard Pircher wrote:
> > --- Urspr?ngliche Nachricht ---
> > Von: Eugene Surovegin <ebs@ebshome.net>
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> > Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> > Datum: Thu, 20 Apr 2006 13:38:48 -0700
> > 
> > There are already non-coherent cache PPC archs (8xx, 4xx) just look 
> > how all this implemented there, don't reinvent the wheel.
> > 
> > Also, read Documentation/DMA-API.txt and DMA-mapping.txt
> I know! Unfortunately this implementation does not work at all with G3/G4
> PPC desktop CPUs for various reasons (for example due to the BAT mapping,
> page tables with different access attributes for the same physical memory
> area allocated by the consistent DMA functions, etc.).

We have the same situation on 44x (all kernel memory is mapped 
through several big TLBs and consistent functions allocate additional 
cache-inhibited mappings for the same physical pages).

-- 
Eugene
