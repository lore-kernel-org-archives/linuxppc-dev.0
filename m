Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id E4B33B7D97
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 02:30:12 +1000 (EST)
Received: by gyf2 with SMTP id 2so2633839gyf.15
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jun 2010 09:30:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LFD.2.00.1006141206110.13427@xanadu.home>
References: <4C13430B.5000907@firmworks.com>
	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop> <4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>
	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>
	<4C146F18.9030008@firmworks.com>
	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>
	<20100614124438.GF9323@yookeroo>
	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>
	<20100614160201.GD9550@shareable.org>
	<alpine.LFD.2.00.1006141206110.13427@xanadu.home>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 14 Jun 2010 10:29:51 -0600
Message-ID: <AANLkTimY8IvWh92kyiJOTZKfb9ddCMeqcTo86cTOytWg@mail.gmail.com>
Subject: Re: Request review of device tree documentation
To: Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Mitch Bradley <wmb@firmworks.com>, Dan Malek <ppc6dev@digitaldans.com>,
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

On Mon, Jun 14, 2010 at 10:23 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Mon, 14 Jun 2010, Jamie Lokier wrote:
>> So requiring that a bootloader can update the DT _independently_ of
>> everything else is a bit much for some devices.
>
> In my opinion, this use case you're illustrating above simply could
> continue to _not_ use DT at all. =A0If your NOR flash is so small that yo=
u
> cannot spare some extra erase blocks, then this is a deeply embedded
> profile the current DT-on-ARM push is not really meant for. =A0You would
> be much better with a minimally configured kernel with all the hardware
> info statically compiled into the kernel and get away without all the DT
> parsing code altogether, like you're already doing today.
>
> While I think DT for ARM has advantages, I don't see us dropping the
> legacy ARM methods anytime soon, especially for existing or extremely
> constrained targets.

I completely agree.

g.
