Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp04.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D5AFB6F85
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 19:28:04 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp04.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7N9RxxT012747
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 14:57:59 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7N9RwmB3924194
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 14:57:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7N9Rw7Y003761
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Aug 2011 14:57:58 +0530
Date: Tue, 23 Aug 2011 14:57:56 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Thiago Jung Bauermann <bauerman@br.ibm.com>,
	Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
	flag
Message-ID: <20110823092756.GB2962@in.ibm.com>
References: <20110819074527.GA21817@in.ibm.com>
	<20110819075338.GC21817@in.ibm.com>
	<20110823050931.GT30097@yookeroo.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110823050931.GT30097@yookeroo.fritz.box>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2011 at 03:09:31PM +1000, David Gibson wrote:
> On Fri, Aug 19, 2011 at 01:23:38PM +0530, K.Prasad wrote:
> > 
> > While PPC_PTRACE_SETHWDEBUG ptrace flag in PowerPC accepts
> > PPC_BREAKPOINT_MODE_EXACT mode of breakpoint, the same is not intimated to the
> > user-space debuggers (like GDB) who may want to use it. Hence we introduce a
> > new PPC_DEBUG_FEATURE_DATA_BP_EXACT flag which will be populated on the
> > "features" member of "struct ppc_debug_info" to advertise support for the
> > same on Book3E PowerPC processors.
> 
> I thought the idea was that the BP_EXACT mode was the default - if the
> new interface was supported at all, then BP_EXACT was always
> supported.  So, why do you need a new flag?
> 

Yes, BP_EXACT was always supported but not advertised through
PPC_PTRACE_GETHWDBGINFO. We're now doing that.

Thanks,
K.Prasad
