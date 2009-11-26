Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EEC911007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:38:56 +1100 (EST)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <807D3910-3357-4DBF-A1C7-9C07A7C80A39@kernel.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<0AE26D40-D051-4CDE-878C-64CC8EF33E07@kernel.crashing.org>
	<1259209436.16367.243.camel@pasglop>
	<807D3910-3357-4DBF-A1C7-9C07A7C80A39@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 09:38:50 +1100
Message-ID: <1259275130.2659.4.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 23:15 +0100, Segher Boessenkool wrote:
> >> If you have only one interrupt controller, like here, you don't
> >> need to refer to it _at all_ :-)
> >
> > I think Linux requires that you do though. It might be a mistake on  
> > our
> > part but heh ...
> 
> Linux doesn't require it; (old) Macs are like this, for example,
> and that works fine.  Oh and all Maple firmwares are like that as
> well I think.  Etc.

It works fine on old macs thanks to a quirk we enable in the mac code
iirc and old maple works thanks to mere luck with the fallback code we
have which reads things of PCI config space :-)

Don't rely on that.

Cheers,
Ben.
