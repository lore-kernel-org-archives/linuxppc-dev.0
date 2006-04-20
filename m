Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 22A6F67A40
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 06:56:34 +1000 (EST)
Date: Thu, 20 Apr 2006 22:56:33 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: Eugene Surovegin <ebs@ebshome.net>
MIME-Version: 1.0
References: <20060420203848.GA23192@gate.ebshome.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <12655.1145566593@www088.gmx.net>
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
> Datum: Thu, 20 Apr 2006 13:38:48 -0700
> 
> There are already non-coherent cache PPC archs (8xx, 4xx) just look 
> how all this implemented there, don't reinvent the wheel.
> 
> Also, read Documentation/DMA-API.txt and DMA-mapping.txt
I know! Unfortunately this implementation does not work at all with G3/G4
PPC desktop CPUs for various reasons (for example due to the BAT mapping,
page tables with different access attributes for the same physical memory
area allocated by the consistent DMA functions, etc.).

regards,

Gerhard

-- 
Echte DSL-Flatrate dauerhaft für 0,- Euro*!
"Feel free" mit GMX DSL! http://www.gmx.net/de/go/dsl
