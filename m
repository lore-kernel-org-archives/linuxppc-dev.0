Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06FC3B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 15:00:41 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id p7Q4s284017430
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:54:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7Q4xIfV1294346
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 14:59:18 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7Q50cB3013928
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2011 15:00:39 +1000
Date: Fri, 26 Aug 2011 14:49:02 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] dtc: remove some warnings
Message-ID: <20110826044902.GJ2308@yookeroo.fritz.box>
References: <20110826112643.f86132d55edc5d452df3ebd0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110826112643.f86132d55edc5d452df3ebd0@canb.auug.org.au>
Cc: John Bonesio <bones@secretlab.ca>, jdl@jdl.com,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 26, 2011 at 11:26:43AM +1000, Stephen Rothwell wrote:
> I assume that these variables were used in the past but not removed when
> their usage was removed.
> 
> Fixes these warnings:
> 
> scripts/dtc/dtc.c: In function 'main':
> scripts/dtc/dtc.c:102:17: warning: variable 'check' set but not used [-Wunused-but-set-variable]
> scripts/dtc/flattree.c: In function 'flat_read_mem_reserve':
> scripts/dtc/flattree.c:700:14: warning: variable 'p' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Yeah, I noticed these gcc 4.6 warnings recently, but didn't get around
to sending a patch.

Jon, please apply.  Uh.. except that this is a patch against the in
kernel dtc, rather than upstream.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
