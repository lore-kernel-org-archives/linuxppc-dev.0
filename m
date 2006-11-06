Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B125067C43
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 09:18:07 +1100 (EST)
Subject: Re: [PATCH] PowerPC: remove broken vsyscall code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
In-Reply-To: <1162850967.29826.62.camel@localhost>
References: <200611062359.10404.sshtylyov@ru.mvista.com>
	<1162849587.28571.356.camel@localhost.localdomain>
	<1162850967.29826.62.camel@localhost>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 09:18:00 +1100
Message-Id: <1162851480.28571.358.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-06 at 14:09 -0800, john stultz wrote:
> On Tue, 2006-11-07 at 08:46 +1100, Benjamin Herrenschmidt wrote:
> > On Mon, 2006-11-06 at 23:59 +0300, Sergei Shtylyov wrote:
> > > Remove vsyscalls that were broken by the PowerPC generic TOD patch, also
> > > fixing the build breakage due to its bad rebase.
> > > 
> > > The patch has been tested on PPC32 only. I had to preserve the data that
> > > are made visible to userland via /proc/ppc64/systemcfg on PPC64, however
> > > now there are only zeroes there and their affect isn't known to me...
> > > 
> > > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> > 
> > There is simply no way this will happen !
> 
> I believe this is just a short-term fix so the ppc tod/rt code can be
> tested. I do plan on getting the ppc vsyscall working before we push any
> ppc tod changes to mainline.

Ok.

Ben.
