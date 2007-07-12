Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E355EDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 22:40:29 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6CCeQbI023769
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 08:40:26 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6CCeQCN222384
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:40:26 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6CCePeN030166
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:40:26 -0600
Subject: Re: [RFC][PATCH 3/8] 4xx MMU
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2FE5C7E5-DF96-49C1-939E-39521A248F9B@kernel.crashing.org>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162179.32199.58.camel@weaponx.rchland.ibm.com>
	<200707112256.38312.arnd@arndb.de>
	<2FE5C7E5-DF96-49C1-939E-39521A248F9B@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 12 Jul 2007 07:40:24 -0500
Message-Id: <1184244024.32199.104.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-07-12 at 02:09 -0500, Kumar Gala wrote:
> > Is it actually feasible to get to a point where
> > you can build a kernel that boots on both
> > 40x and 44x, or is it just too different?
> 
> I'm guessing its too different since 40x probably has a real mode and  
> 44x doesnt.

Among other things.

> However, I agree we should go ahead and rename 4xx to 40x at this  
> point in arch/powerpc.

Yeah.  See my response to Arnd about getting a git tree in place to do
it.  RSN :)

josh
