Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <D8DEC759-EAB9-457F-AF7B-A10D6593B27A@freescale.com>
References: <200509090008.39692.pantelis.antoniou@gmail.com>
	<D8DEC759-EAB9-457F-AF7B-A10D6593B27A@freescale.com>
Content-Type: text/plain
Date: Sat, 10 Sep 2005 08:19:54 +1000
Message-Id: <1126304395.29803.52.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, pantelis.antoniou@gmail.com
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> I think she lost the I in ICACHE... its a power5 only feature at this  
> point.

And good old 601 too :) It has a unified cache. We could make a common
feature bit for these.

Ben.
