Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25089B7113
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Feb 2011 11:00:31 +1100 (EST)
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p12Ngg18004438
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 18:42:44 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 47A45728047
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 19:00:28 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1300R5I1675282
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 19:00:27 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1300Qen011495
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 22:00:27 -0200
Subject: Re: [PATCH V2 1/6] powerpc: Move udbg_early_init() after
	early_init_devtree()
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20110202230643.GF3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-2-git-send-email-shaggy@linux.vnet.ibm.com>
	<20110202230643.GF3032@yookeroo>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Wed, 02 Feb 2011 18:00:25 -0600
Message-ID: <1296691225.12290.112.camel@shaggy-w500>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-02-03 at 10:06 +1100, David Gibson wrote:
> On Tue, Feb 01, 2011 at 12:48:41PM -0600, Dave Kleikamp wrote:
> > so that it can use information from the device tree.
> 
> Hrm.  On the other hand this means that the early_init_devtree() code
> can't benefit from hardcoded early debugging.  Since you don't
> actually appear to use devtree information in udbg_early_init() in the
> latest series, I'd suggest dropping this patch.

Patch 2 depends on early_init_devtree() being run.  Until then, I don't
know of a way to get at the bootargs.
-- 
Dave Kleikamp
IBM Linux Technology Center
