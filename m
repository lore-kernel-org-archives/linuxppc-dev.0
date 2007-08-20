Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 224F7DDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 01:53:27 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7KFrOIL012522
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 11:53:24 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7KFrONf265312
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 09:53:24 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7KFrNfX020173
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Aug 2007 09:53:24 -0600
Date: Mon, 20 Aug 2007 10:53:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Message-ID: <20070820105322.35095ae0@weaponx.rchland.ibm.com>
In-Reply-To: <46C9B6DF.1000006@freescale.com>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820060000.GA26100@localhost.localdomain>
	<A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
	<20070820103719.23f50f64@weaponx.rchland.ibm.com>
	<46C9B6DF.1000006@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Gibson <david@gibson.dropbear.id.au>, David
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 20 Aug 2007 10:44:31 -0500
Scott Wood <scottwood@freescale.com> wrote:

> Josh Boyer wrote:
> > On Mon, 20 Aug 2007 10:32:43 -0500
> > Kumar Gala <galak@kernel.crashing.org> wrote:
> >>Do we want to go and move stuff back out of arch/powerpc/kernel back  
> >>into arch/ppc/kernel?  or just include files?
> > 
> > 
> > What would be the point of doing that?  I would think we want the
> > opposite, in that we want to reuse as much of arch/powerpc during
> > arch/ppc compiles as possible.  Sort of shows how much is "left" to
> > port.
> 
> The point would be to keep the two trees separate, so that one doesn't 
> need to worry about breaking arch/ppc when making a change to arch/powerpc.

Who worries about that? ;).

Ok, I can see that.  Still seems wasteful to me though.

josh
