Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB589DDE10
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 20:11:22 +1000 (EST)
Subject: Re: [patch 29/30] PS3: Device tree source.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <3fa8fff1a1c5b1b353aab4f1ef014804@kernel.crashing.org>
References: <20070612181825.730300780@am.sony.com> >
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<1181774580.14818.337.camel@localhost.localdomain>
	<3fa8fff1a1c5b1b353aab4f1ef014804@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 20:11:09 +1000
Message-Id: <1181815870.14818.401.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-14 at 09:31 +0200, Segher Boessenkool wrote:
> >> It should include "sony,", in the "name" property at least.
> >>
> >> "model" same as "name" cannot make sense either.
> >
> > Dunno what you are on about the model vs. name but this is the root of
> > the DT, it has no name.
> 
> Please review the OF spec, sections 3.4 and the "/" entry
> of 3.5.
> 
> I'f the flat device tree doc and/or code says differently
> here, that is a bug.

Well, I wonder if that's been superceeded by some RFC or never validated
addition ... None of the Apple trees for example has a /name property
and the idea of having a node with a name that doesn't participate in
the path resolution in just wrong. We should check but I don't think IBM
trees have one either.

So I stand by the way I defined the flat DT -> no name in the root. But
you are welcome to use compatible and model.

Ben.
