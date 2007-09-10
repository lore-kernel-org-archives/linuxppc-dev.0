Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 570BFDDE28
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:44:06 +1000 (EST)
Date: Mon, 10 Sep 2007 18:43:34 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.23-rc4-mm1 -- powerpc per_cpu__cpu_sibling_map compile failure
Message-ID: <20070910174334.GB30335@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831215822.26e1432b.akpm@linux-foundation.org>
Cc: mel@csn.ul.ie, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am seeing the following compile error on all of my powerpc platforms:

  CC      kernel/sched.o
  kernel/sched.c: In function `cpu_to_phys_group':
  kernel/sched.c:5937: error: `per_cpu__cpu_sibling_map' undeclared (first use in this function)
  kernel/sched.c:5937: error: (Each undeclared identifier is reported only once
  kernel/sched.c:5937: error: for each function it appears in.)
  kernel/sched.c:5937: warning: type defaults to `int' in declaration of `type name'
  kernel/sched.c:5937: error: invalid type argument of `unary *'
  kernel/sched.c: In function `build_sched_domains':
  kernel/sched.c:6172: error: `per_cpu__cpu_sibling_map' undeclared (first use in this function)
  kernel/sched.c:6172: warning: type defaults to `int' in declaration of `type name'
  kernel/sched.c:6172: error: invalid type argument of `unary *'
  kernel/sched.c:6183: warning: type defaults to `int' in declaration of `type name'
  kernel/sched.c:6183: error: invalid type argument of `unary *'
  make[1]: *** [kernel/sched.o] Error 1
  make: *** [kernel] Error 2

-apw
