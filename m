Return-Path: <compudj@krystal.dyndns.org>
Received: from toq11-srv.bellnexxia.net (toq11.bellnexxia.net
	[209.226.175.118]) by ozlabs.org (Postfix) with ESMTP id AFCE3DDDF8
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Sep 2007 00:56:26 +1000 (EST)
Received: from krystal.dyndns.org ([76.65.103.147])
	by tomts16-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070922143541.EKXD574.tomts16-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 10:35:41 -0400
Date: Sat, 22 Sep 2007 10:35:41 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 04/28] Add cmpxchg64 and cmpxchg64_local to powerpc
Message-ID: <20070922143540.GA12865@Krystal>
References: <20070827155234.062715780@polymtl.ca>
	<20070827155524.827591009@polymtl.ca>
	<18164.40462.991761.909735@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18164.40462.991761.909735@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Paul Mackerras (paulus@samba.org) wrote:
> Mathieu Desnoyers writes:
> 
> > Make sure that at least cmpxchg64_local is available on all architectures to use
> > for unsigned long long values.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
> 
> Acked-by: Paul Mackerras <paulus@samba.org>

Thanks Paul,

Just make sure add-cmpxchg-local-to-generic-for-up.patch gets merged
before this one, since it needs asm-generic/cmpxchg-local.h.

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
