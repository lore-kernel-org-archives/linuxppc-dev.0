Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 957B767C86
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 05:33:25 +1100 (EST)
Date: Thu, 9 Nov 2006 19:33:07 +0100
From: Olaf Hering <olh@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: ppc32 PIO recovery mecanism
Message-ID: <20061109183307.GA22683@suse.de>
References: <1162773695.28571.260.camel@localhost.localdomain>
	<1162775915.3415.2.camel@shinybook.infradead.org>
	<20061106061148.GA4361@suse.de>
	<1162794242.3415.28.camel@shinybook.infradead.org>
	<20061106062559.GB4361@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061106062559.GB4361@suse.de>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 06, Olaf Hering wrote:

> On Mon, Nov 06, David Woodhouse wrote:
> 
> > Did ISAPnP get fixed?
> 
> I have to check, only PReP systems have ISA slots.

isapnp_init() has your change. I loaded all the ISA network drivers,
none of them crashed the pismo.

Also, I do not plan to reenable CONFIG_ISA. And there is no autoprobing
for ISA hardware, so I dont think it will cause any trouble if distros
ship stuff like aha1542.ko for 32bit kernels.
