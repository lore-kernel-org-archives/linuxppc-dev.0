Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C826DDE21
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:26:53 +1100 (EST)
Subject: Re: Program Check (700) in lpar.c:551     was: Re: patches in
	powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1170882968.2620.296.camel@localhost.localdomain>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
	<1170882651.6619.64.camel@localhost>
	<1170882968.2620.296.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 08:26:47 +1100
Message-Id: <1170883607.2620.299.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-08 at 08:16 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2007-02-07 at 15:10 -0600, Will Schmidt wrote:
> > On Wed, 2007-07-02 at 15:03 +1100, Paul Mackerras wrote:
> > >       [POWERPC] Make pSeries use the H_BULK_REMOVE hypervisor call
> > 
> > 
> > looks like this one ( f03e64f2ca6ee3d0b7824536b1940497701fe766 ) makes
> > my JS20 tip over.    I backed it just that patch and booted
> > successfully, but havnt done any more poking than that. 
> 
> What about "di c000000000035744" ?
> 
> Would it be possible that H_BULK_REMOVE isn't implemented by the js20's
> firmware ?

I talked to Mark Hack and indeed, it's not supported on js20. I asked
him the proper way to verify if it's supported via
ibm,hypertas-functions, specifically the hcall-bulk group.

Ben.
