Return-Path: <mkravetz@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C46767BD0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 10:25:04 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k740P1i7003492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 20:25:01 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k740GKRO282760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 18:25:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7408Nc8018444
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Aug 2006 18:08:23 -0600
Date: Thu, 3 Aug 2006 17:08:49 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [RFC] asm code for Hypervisor Call Instrumentation
Message-ID: <20060804000849.GB3537@monkey.ibm.com>
References: <20060802175947.GA7489@w-mikek2.ibm.com>
	<20060803135717.754bd37f.sfr@canb.auug.org.au>
	<20060803040506.GB3484@monkey.ibm.com>
	<20060803174058.GA3179@w-mikek2.ibm.com>
	<20060804092552.41f00701.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060804092552.41f00701.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 04, 2006 at 09:25:52AM +1000, Stephen Rothwell wrote:
> I would have thought that
> 
> #define HCALL_INST_PRECALL
> 
> would work.

It does work.  That was too obvious for me. :)

-- 
Mike
