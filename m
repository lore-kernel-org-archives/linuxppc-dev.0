Return-Path: <dwg@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1EB33B7C73
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 21:38:29 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9041DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 21:38:27 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n7SBa4op008748
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 21:36:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SBcPYi1290490
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 21:38:25 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SBcOKe025179
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 21:38:25 +1000
Date: Fri, 28 Aug 2009 21:23:22 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RFC] Clock binding
Message-ID: <20090828112322.GA16192@yookeroo.seuss>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop>
	<4A96F69A.5050003@firmworks.com>
	<1251411532.20467.74.camel@pasglop>
	<4A970C85.8090703@firmworks.com>
	<1251420686.20467.96.camel@pasglop>
	<4A974295.9020504@firmworks.com>
	<1251427388.20467.122.camel@pasglop>
	<20090828105837.GC25303@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090828105837.GC25303@zod.rchland.ibm.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 06:58:37AM -0400, Josh Boyer wrote:
> On Fri, Aug 28, 2009 at 12:43:08PM +1000, Benjamin Herrenschmidt wrote:
> >On Thu, 2009-08-27 at 16:36 -1000, Mitch Bradley wrote:
> >> The idea of a wiki as a registration authority is a good one, but I'm 
> >> not volunteering to maintain it :-)
> >
> >here goes my hope :-)
> >
> >Do we have wiki's we could use on power.org or should we aim for a
> >community place ? Anybody has suggestions ? I wouldn't even try to
> >maintain a web site myself, that would be irresponsible of anybody to
> >let me do so !
> 
> This is about the 3rd or 4th time this idea has come up over the past couple
> of years.  Maybe this time it will stick?

There actually was one set up on power.org, for epapr bindings.  I'm
still digging around to try to relocate the address, though.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
