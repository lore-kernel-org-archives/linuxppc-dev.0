Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5CD40DDF13
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 12:15:22 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m261EXHV004085
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 20:14:33 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m261FJJV194018
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 18:15:19 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m261FJR6016220
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 18:15:19 -0700
Date: Wed, 5 Mar 2008 19:12:16 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] PowerPC 4xx: Add dcri_clrset() for locked
	read/modify/write functionality
Message-ID: <20080305191216.5089f696@zod.rchland.ibm.com>
In-Reply-To: <1204761978.21545.240.camel@pasglop>
References: <20080305183804.GA21760@ru.mvista.com>
	<1204761978.21545.240.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 06 Mar 2008 11:06:18 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2008-03-05 at 21:38 +0300, Valentine Barshak wrote:
> > This adds dcri_clrset() macro which does read/modify/write
> > on indirect dcr registers while holding indirect dcr lock.
> > 
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Indeed, looks good.  Valentine, are you going to rework your EMAC patch
to use this?

josh
