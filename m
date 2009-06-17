Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 06B8AB71E3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 20:11:16 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6437FDDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 20:11:14 +1000 (EST)
Subject: Re: [PATCH] powerpc/mm: Fix potential access to freed pages when
	using hugetlbfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4A38B4EA.20507@in.ibm.com>
References: <20090616025419.A5581DDD1B@ozlabs.org> <4A38B4EA.20507@in.ibm.com>
Content-Type: text/plain
Date: Wed, 17 Jun 2009 20:11:00 +1000
Message-Id: <1245233460.21602.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Thanks for the patch. The machine survived after two days of
> testing with hugetlbfs tests.

Excellent, thanks for testing, I'll merge it with my next batch.

Cheers,
Ben.
