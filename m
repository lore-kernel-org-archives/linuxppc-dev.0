Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61510B6F6F
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 14:00:15 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7O3sr59010264
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 13:54:53 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7O40FEF1687708
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 14:00:15 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7O40EAc000936
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2011 14:00:14 +1000
Date: Wed, 24 Aug 2011 14:00:10 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
	flag
Message-ID: <20110824040010.GC30097@yookeroo.fritz.box>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
	<20110823092756.GB2962@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110823092756.GB2962@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2011 at 02:57:56PM +0530, K.Prasad wrote:
> On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> > On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > > 
> > > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > > "features" member of "struct ppc_debug_info" to advertise support for the
> > > same on Book3E PowerPC processors.
> > 
> > I thought the idea was that the BP_EXACT mode was the default - if the
> > new interface was supported at all, then BP_EXACT was always
> > supported.  So, why do you need a new flag?
> > 
> 
> Yes, BP_EXACT was always supported but not advertised through
> PPC_PTRACE_GETHWDBGINFO. We're now doing that.

I can see that.  But you haven't answered why.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
