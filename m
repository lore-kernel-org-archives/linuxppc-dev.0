Return-Path: <pestes@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D89567A64
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 23:21:23 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j3KDLJEC007022
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 09:21:19 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j3KDLJ3a090568
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 09:21:19 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j3KDLJPA019237
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Apr 2005 09:21:19 -0400
From: Phil Estes <pestes@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <16996.54212.518924.846267@cargo.ozlabs.ibm.com>
References: <1113853327.3750.21.camel@unary.wma.ibm.com>
	<16996.54212.518924.846267@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 09:21:06 -0400
Message-Id: <1114003266.12720.1.camel@unary.wma.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: writev test failure related to arch/ppc/lib/string.S changes?
Reply-To: pestes@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-04-19 at 19:47 +1000, Paul Mackerras wrote:

> Yeah.  This patch should fix it.  Mind testing it and letting us know
> how it goes?
> 
> Paul.
> 

Patch fixes the failure path--works great.  Thanks very much.

- Phil
