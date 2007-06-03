Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1153FDDE20
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 07:05:47 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <46630256.8050909@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 04 Jun 2007 07:04:30 +1000
Message-Id: <1180904670.31677.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-06-03 at 22:03 +0400, Sergei Shtylyov wrote:
> >> the CFI/JEDEC interface then can be deduced by probing
> 
> > Most of the time, sure.  Not always.
> 
>     That's the way the cookie crumbles in Linux MTD for now. It's
> *always* 
> detecting this by probing -- you only can say what [not] to probe. 

So you are saying that because the current linux MTD stuff can only
probe (which doesn't always work), we should not put the proper chip
interface type in the device-tree ?

Your argument makes no sense to me.

Put the proper interface informations in the device-tree, maybe some OS
smarter than linux will make good use on it and maybe linux will be
fixed at one point too (not by you, of course, you gave us that line
often enough about not being paid to do the right thing).

Ben.
