Return-Path: <dave@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 16118DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 01:13:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3SFF0HS023557
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:15:00 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3SFD07O090212
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:13:00 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3SFB9bv028583
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 11:11:11 -0400
Subject: Re: [PATCH 1/3] IB/ehca: Replace vmalloc with kmalloc
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
In-Reply-To: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
References: <200904211716.45245.ossrosch@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Apr 2009 08:12:51 -0700
Message-Id: <1240931572.29485.77.camel@nimitz>
Mime-Version: 1.0
Cc: fenkes@de.ibm.com, LKML <linux-kernel@vger.kernel.org>,
	OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	alexschm@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-04-21 at 17:16 +0200, Stefan Roscher wrote:
> From: Anton Blanchard <antonb at au1.ibm.com>
> 
> To improve performance of driver ressource allocation,
> replace the vmalloc() call with kmalloc().

Just curious, but how big are these allocations?  Why was vmalloc() even
ever used if we know they'll be small?

-- Dave
