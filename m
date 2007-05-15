Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 07D3FDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 11:03:35 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F13WVC008218
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:03:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F13WoI487322
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:03:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F13Wh8012424
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 21:03:32 -0400
Subject: Re: [PATCH 2/3] Bamboo platform support
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070515105837.204d080f.sfr@canb.auug.org.au>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154743.3420.25.camel@zod.rchland.ibm.com>
	<20070515105837.204d080f.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 14 May 2007 20:03:23 -0500
Message-Id: <1179191003.3420.78.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 10:58 +1000, Stephen Rothwell wrote:
> Hi Josh,
> 
> On Mon, 14 May 2007 09:59:03 -0500 Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> >
> > @@ -35,6 +35,7 @@ config 440EP
> >  	bool
> >  	select PPC_FPU
> >  	select IBM440EP_ERR42
> > +#	select IBM_NEW_EMAC_ZMII
> 
> This bit belongs in a separate patch (I assume it slipped in by accident).

Wasn't by accident.  I was following the lead of what was done for
Ebony/440GP (which is actually broken at the moment but has a patch
pending to comment it out as above).

There is no ethernet period without the new EMAC rewrite and I'd like to
leave the select there but commented out to serve as a placeholder if
nothing else.  Of course, if there are lots of objections it can be
pulled.

josh
