Return-Path: <johnstul@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D438567C26
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 09:12:01 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA6MBq1p023710
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:11:52 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA6MBqAC228328
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:11:52 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA6MBpOT021023
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:11:51 -0500
Subject: Re: [PATCH] PowerPC: remove broken vsyscall code
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1162849587.28571.356.camel@localhost.localdomain>
References: <200611062359.10404.sshtylyov@ru.mvista.com>
	<1162849587.28571.356.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 14:09:27 -0800
Message-Id: <1162850967.29826.62.camel@localhost>
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

On Tue, 2006-11-07 at 08:46 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2006-11-06 at 23:59 +0300, Sergei Shtylyov wrote:
> > Remove vsyscalls that were broken by the PowerPC generic TOD patch, also
> > fixing the build breakage due to its bad rebase.
> > 
> > The patch has been tested on PPC32 only. I had to preserve the data that
> > are made visible to userland via /proc/ppc64/systemcfg on PPC64, however
> > now there are only zeroes there and their affect isn't known to me...
> > 
> > Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> There is simply no way this will happen !

I believe this is just a short-term fix so the ppc tod/rt code can be
tested. I do plan on getting the ppc vsyscall working before we push any
ppc tod changes to mainline.

thanks
-john
