Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70CDBDDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 20:44:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3D9i2cS028798
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 05:44:02 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3DAimoh308976
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 06:44:48 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3DAimGV018451
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 06:44:48 -0400
Date: Fri, 13 Apr 2007 05:52:15 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix PowerPC 750CL CPU features
Message-ID: <20070413105214.GA23995@crusty.rchland.ibm.com>
References: <1176382146.6379.28.camel@zod.rchland.ibm.com>
	<aeef7937e978aec33074251c48dca389@kernel.crashing.org>
	<1176431310.5764.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176431310.5764.54.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 13, 2007 at 12:28:30PM +1000, Benjamin Herrenschmidt wrote:
> > The difference between these two is
> > 
> > #define CPU_FTRS_750GX  (CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS)
> > #define CPU_FTRS_750    (CPU_FTR_COMMON)
> > 
> > 750GX excludes COMMON, which seems like a bug.  With
> > your change, 750CL uses DUAL_PLL_750FX; does it actually
> > have that feature?
> 
> Looks indeed like that lack of COMMON in the GX entry is a bug...
> 
> Josh, care to fix that too while at it ? :-)

I did.  See patch version 2. :)

josh
