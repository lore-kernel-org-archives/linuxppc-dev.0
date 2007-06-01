Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BA48DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 09:28:33 +1000 (EST)
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 09:28:24 +1000
Message-Id: <1180740504.19517.478.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 20:58 +0200, Segher Boessenkool wrote:
> > +		ranges = <00000000 f8000000 00100000
> > +			  80000000 80000000 20000000
> > +			  e2000000 e2000000 00100000
> > +			  a0000000 a0000000 20000000
> > +			  e3000000 e3000000 00100000>;
> >  		reg = <f8000000 00100000>;	// CCSRBAR 1M
> 
> 
> "reg" included in "ranges"?  Something is wrong here.

Indeed. To be more precise, "ranges" is what gets forwarded to childs.
"reg" is what gets decoded by the bridge itself...

Cheers,
Ben.
