Return-Path: <johnstul@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64AB667B95
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 10:56:34 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7H0uUce015656
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 20:56:30 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7H0uCKK348540
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 18:56:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7H0uB1Q012295
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 18:56:12 -0600
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: john stultz <johnstul@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155774368.11312.135.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	<17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	<yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	<1155318983.5337.2.camel@localhost.localdomain>
	<1155771487.11312.114.camel@localhost.localdomain>
	<1155772859.15360.12.camel@localhost.localdomain>
	<1155774368.11312.135.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 17:56:10 -0700
Message-Id: <1155776171.15360.22.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 02:26 +0200, Benjamin Herrenschmidt wrote:
> > Hey Ben,
> > 	I appreciate your looking over my patch. You are correct, the
> > conversion is a bit rough and I've not yet been able to work on the
> > powerpc vDSO, although I'd like to get it working so any help or
> > suggestions would be appreciated (is there a reason the vDSO is written
> > in ASM?).
> > 
> > If you have any other concerns w/ that patch, or the generic timekeeping
> > code, please let me know and I'll do what I can to address them.
> 
> Well, I've been wanting to look at your stuff and possibly do the
> conversion for some time, provided we don't lose performances ... Our
> current implementation is very optimized to avoid even memory barriers
> in most cases and I doubt we'll be able to be as fine tuned using your
> generic code, thus it's a tradeoff decision that we have to do. But
> then, I need to look into the details before doing any final
> statement :)

Ok, although do let me know if you see places where the generic code
could use any of the optimizations used in powerpc.

thanks
-john
