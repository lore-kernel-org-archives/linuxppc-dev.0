Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C220067C2D
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:44:07 +1000 (EST)
Date: Mon, 2 Oct 2006 21:44:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
Message-Id: <20061002214400.0a83b743.akpm@osdl.org>
In-Reply-To: <1159850245.5482.32.camel@localhost.localdomain>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de>
	<1159850245.5482.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Adrian Bunk <bunk@stusta.de>, linuxppc-dev@ozlabs.org,
	Judith Lebzelter <judith@osdl.org>,
	Kernel list <linux-kernel@vger.kernel.org>, Linux
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 03 Oct 2006 14:37:25 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> > > You might want to convince Andrew accepting my patch to make 
> > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > people more aware of this problem...
> > >...
> 
> Andrew, is there any reason not to take that patch ?

It generates lots of warnings from drivers which nobody does any work on.

Net result: lots of new warnings, no fixed bugs.
