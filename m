Return-Path: <pan@nt.tu-darmstadt.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8761BB7D64
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 19:53:35 +1000 (EST)
Message-ID: <4C189D1C.6050304@nt.tu-darmstadt.de>
Date: Wed, 16 Jun 2010 11:45:00 +0200
From: Vladimir Pantelic <pan@nt.tu-darmstadt.de>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: Request review of device tree documentation
References: <4C13430B.5000907@firmworks.com>	<1276339529.1962.184.camel@pasglop>	<1276339684.1962.186.camel@pasglop>	<4C13B618.1030006@firmworks.com>	<1276383132.1962.195.camel@pasglop>	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>	<4C146F18.9030008@firmworks.com>	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>	<20100614124438.GF9323@yookeroo>	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>	<20100614160201.GD9550@shareable.org>	<4C165FD1.6080505@firmworks.com>
	<4C186AA8.4040709@compulab.co.il>	<4C186B7B.1060308@firmworks.com>
	<4C186C72.2020506@compulab.co.il>	<4C187013.5000400@firmworks.com>
	<4C18738C.4090809@compulab.co.il> <4C187FF0.5020806@firmworks.com>
In-Reply-To: <4C187FF0.5020806@firmworks.com>
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

>>  I'm also objecting the step (b) and, fortunately, it's not yet the
>>  status quo.
>>  Current U-Boot/kernel implementations I've encountered still do not
>>  have OS calls to resident HW access routines. But if such calls would
>>  be allowed, my impression is that SoC vendors would make extensive use
>>  of them.
>
> One could argue that a feature that vendors would use extensively is one
> that is sorely needed from their point of view.

yes, it would free them from writing these pesky linux drivers and getting
them into mainline :)
