Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] fixes for the SLB shadow buffer 
In-reply-to: <1186046080.5495.620.camel@localhost.localdomain> 
References: <17055.1185944172@neuling.org>
	<18096.6654.934841.561238@cargo.ozlabs.ibm.com>
	<31580.1185948147@neuling.org>
	<1186004885.22717.50.camel@farscape.rchland.ibm.com>
	<24613.1186034191@neuling.org>
	<1186039870.5495.595.camel@localhost.localdomain>
	<13166.1186045008@neuling.org>
	<1186045096.5495.617.camel@localhost.localdomain>
	<17854.1186045405@neuling.org>
	<1186046080.5495.620.camel@localhost.localdomain>
Date: Thu, 02 Aug 2007 19:28:15 +1000
Message-ID: <30559.1186046895@neuling.org>
Cc: linuxppc-dev@ozlabs.org, will_schmidt@vnet.ibm.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Thu, 2007-08-02 at 19:03 +1000, Michael Neuling wrote:
> > > 
> > > Ok, that was missing from your description :-)
> > 
> > Sorry... so ditch the barriers? 
> 
> As you like. The reason why you can ditch them is purely because you
> know for sure that the only case the firmware will access those shadows
> from another CPU is that one and it happens to be just right. What are
> the chances that in the future, FW will do something different and
> nobody will "fix" the code ?

Yep, I might chat to some PHYP guys and see what they think.

> Considering that eieios are fairly cheap and it's not a very hot code
> path as far as I can tell, I'd rather keep them.

OK.  I'll keep them in for now and submit an optimisation patch later if
need be.

Mikey
