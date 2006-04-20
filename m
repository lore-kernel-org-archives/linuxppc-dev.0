Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 96E4D67A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 07:10:57 +1000 (EST)
Date: Thu, 20 Apr 2006 23:10:55 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Eugene Surovegin <ebs@ebshome.net>
MIME-Version: 1.0
References: <20060420210201.GA25755@gate.ebshome.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <10026.1145567455@www088.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> --- Ursprüngliche Nachricht ---
> Von: Eugene Surovegin <ebs@ebshome.net>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
> Datum: Thu, 20 Apr 2006 14:02:01 -0700
> 
> On Thu, Apr 20, 2006 at 10:56:33PM +0200, Gerhard Pircher wrote:
> > > --- Urspr?ngliche Nachricht ---
> > > Von: Eugene Surovegin <ebs@ebshome.net>
> > > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > > Kopie: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
> > > Betreff: Re: Not coherent cache DMA for G3/G4 CPUs: clarification
> > > needed
> > > Datum: Thu, 20 Apr 2006 13:38:48 -0700
> > > 
> > > There are already non-coherent cache PPC archs (8xx, 4xx) just look 
> > > how all this implemented there, don't reinvent the wheel.
> > > 
> > > Also, read Documentation/DMA-API.txt and DMA-mapping.txt
> > I know! Unfortunately this implementation does not work at all with
> > G3/G4 PPC desktop CPUs for various reasons (for example due to the BAT
> > mapping, page tables with different access attributes for the same
> > physical memory area allocated by the consistent DMA functions, etc.).
> 
> We have the same situation on 44x (all kernel memory is mapped 
> through several big TLBs and consistent functions allocate additional 
> cache-inhibited mappings for the same physical pages).

Well, Freescale's PPC programming environment manual clearly states that
this will not work on G4 CPUs (74xx). Also Benjamin Herrenschmidt told me,
that this implementation will not work for the reasons I mentioned before. 
The approach I'm trying to implement was his idea, so I have to trust in
him.

regards,

Gerhard

-- 
GMX Produkte empfehlen und ganz einfach Geld verdienen!
Satte Provisionen für GMX Partner: http://www.gmx.net/de/go/partner
