Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D768DDEFD
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 01:18:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1DEIkwN011122
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 09:18:46 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1DEIkn8512030
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:18:46 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1DEIkPO026610
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 07:18:46 -0700
Subject: Re: [PATCH 1/16] Remove ibm4{xx,4x}.h from arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213061024.4A283DDD0C@ozlabs.org>
References: <20070213061024.4A283DDD0C@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 08:19:49 -0600
Message-Id: <1171376389.4003.33.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:10 +1100, David Gibson wrote:
> ARCH=powerpc should not use the ghastly un-multiplatformable tangle of
> includes that starts with asm-ppc/ibm4xx.h.  This patch removes a
> compile-breaking include of it from head_44x.S.

This one is in paulus' tree.  Just an FYI for those wanting to try
these.

josh
