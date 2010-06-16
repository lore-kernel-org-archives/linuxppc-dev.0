Return-Path: <mike@compulab.co.il>
Received: from compulab.co.il (compulab.co.il [67.18.134.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F8E91007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 17:02:53 +1000 (EST)
Message-ID: <4C186AA8.4040709@compulab.co.il>
Date: Wed, 16 Jun 2010 09:09:44 +0300
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: Request review of device tree documentation
References: <4C13430B.5000907@firmworks.com>	<1276339529.1962.184.camel@pasglop>	<1276339684.1962.186.camel@pasglop>	<4C13B618.1030006@firmworks.com>	<1276383132.1962.195.camel@pasglop>	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>	<4C146F18.9030008@firmworks.com>	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>	<20100614124438.GF9323@yookeroo>	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>	<20100614160201.GD9550@shareable.org>
	<4C165FD1.6080505@firmworks.com>
In-Reply-To: <4C165FD1.6080505@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Mike Rapoport <mike@compulab.co.il>, Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	linux-arm-kernel@lists.infradead.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mitch Bradley wrote:

> The second topic is the hypothetical use of OFW as a HAL. That will not 
> happen for several reasons.  The opposition to the idea is widespread 
> and deeply held, and there are good arguments to support that 
> opposition.   Furthermore, the economic conditions necessary for the 
> creation of such a HAL do not exist in the ARM world, nor indeed in the 
> Linux world in general.  (The necessary condition is the ability for one 
> company to impose a substantial change by fiat - essentially a monopoly 
> position.)
> 
> Shall we agree, then, that any further discussion of the HAL issue is 
> "just for fun", and that nobody needs to feel threatened that it would 
> actually happen?

I've recently worked with vendor versions of U-Boot for advanced ARM 
SoCs. There is already *huge* chunk of HAL code in those versions. And 
if there would be possibility to have callbacks into the firmware these 
chunks would only grow, IMHO.


> The potential for "vendors breaking out of the debugging use case and 
> turning it into a HAL" is miniscule, because
> 
> a) The callback is disabled by default
> b) The technical challenges of the callback interface limit its 
> applicability to specific "wizard user" scenarios
> c) OFW is unlikely to achieve sufficient market penetration for the HAL 
> thing to be worth doing
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Sincerely yours,
Mike.
