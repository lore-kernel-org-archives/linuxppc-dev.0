Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BACB067C3A
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 14:50:28 +1000 (EST)
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061002214400.0a83b743.akpm@osdl.org>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de>
	<1159850245.5482.32.camel@localhost.localdomain>
	<20061002214400.0a83b743.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 14:49:39 +1000
Message-Id: <1159850979.5482.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-02 at 21:44 -0700, Andrew Morton wrote:
> On Tue, 03 Oct 2006 14:37:25 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > > > You might want to convince Andrew accepting my patch to make 
> > > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > > people more aware of this problem...
> > > >...
> > 
> > Andrew, is there any reason not to take that patch ?
> 
> It generates lots of warnings from drivers which nobody does any work on.
> 
> Net result: lots of new warnings, no fixed bugs.

Are you sure the warnings won't cause somebody like Al to go through
them all and fix them ?

At least they should be marked either CONFIG_BROKEN or X86 only (or
whatever arch they are supposed to be used on).

Ben.
