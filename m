Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 870581A0050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:12:41 +1100 (AEDT)
Message-ID: <54461576.1060006@c-s.fr>
Date: Tue, 21 Oct 2014 10:12:38 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: kernel 3.17 - perf build failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

   LINK     perf
libperf.a(skip-callchain-idx.o): In function `arch_skip_callchain_idx':
/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:250: 
undefined reference to `pr_debug'
libperf.a(skip-callchain-idx.o): In function `check_return_addr':
/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:188: 
undefined reference to `pr_debug'
libperf.a(skip-callchain-idx.o): In function `arch_skip_callchain_idx':
/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:250: 
undefined reference to `pr_debug'
libperf.a(skip-callchain-idx.o): In function `check_return_addr':
/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:165: 
undefined reference to `pr_debug'
/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:171: 
undefined reference to `pr_debug'
libperf.a(skip-callchain-idx.o):/root/gen/trunk/knl/tools/perf/arch/powerpc/util/skip-callchain-idx.c:101: 
more undefined references to `pr_debug' follow
collect2: ld returned 1 exit status
make[1]: *** [perf] Error 1
make: *** [install] Error 2
