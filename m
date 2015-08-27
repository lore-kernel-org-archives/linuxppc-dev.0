Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id F29441A05BE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 23:59:02 +1000 (AEST)
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: leroy christophe <christophe.leroy@c-s.fr>
Subject: Strange reports of perf events on powerpc 83xx
Message-ID: <55DF17A3.7070009@c-s.fr>
Date: Thu, 27 Aug 2015 15:58:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Has anybody already used 'perf' tool on powerpc MPC83xx ?

I have been succesfully using perf on MPC8xx, but on MPC83xx I get 
something strange.

perf record/report reports addresses on user stack, as if it was mixing 
up D accesses and I accesses.

Any idea of what the problem can be ?

# Samples: 8K of event 'cpu-clock'
# Event count (approx.): 2196000000
#
# Overhead  Command       Shared Object       Symbol
# ........  ............  .................. 
............................................
#
      2.62%  perf_reseau4  libpthread-2.18.so  [.] __libc_send
      2.56%  perf_reseau4  [kernel.kallsyms]   [k] __ip_make_skb
      1.62%  perf_reseau4  [kernel.kallsyms]   [k] __ip_append_data.isra.39
      1.55%  perf_reseau4  [kernel.kallsyms]   [k] ip_finish_output
      1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd94
      1.33%  perf_reseau4  [unknown]           [k] 0x7ffffd95
      1.28%  perf_reseau4  [unknown]           [k] 0x7ffffd97
      1.26%  perf_reseau4  [unknown]           [k] 0x7ffffda3
      1.24%  perf_reseau4  [unknown]           [k] 0x7ffffd98
      1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd92
      1.22%  perf_reseau4  [unknown]           [k] 0x7ffffd9b
      1.22%  perf_reseau4  [unknown]           [k] 0x7ffffdaa
      1.21%  perf_reseau4  [unknown]           [k] 0x7ffffd96
      1.18%  perf_reseau4  [unknown]           [k] 0x7ffffda7
      1.17%  perf_reseau4  [unknown]           [k] 0x7ffffd8d
      1.17%  perf_reseau4  [unknown]           [k] 0x7ffffd99
      1.13%  perf_reseau4  [unknown]           [k] 0x7ffffd90
      1.13%  perf_reseau4  [unknown]           [k] 0x7ffffda2
      1.12%  perf_reseau4  [kernel.kallsyms]   [k] __local_bh_enable_ip
      1.12%  perf_reseau4  [unknown]           [k] 0x7ffffd9c
      1.12%  perf_reseau4  [unknown]           [k] 0x7ffffd9e
      1.10%  perf_reseau4  [unknown]           [k] 0x7ffffda0
      1.08%  perf_reseau4  [unknown]           [k] 0x7ffffd9f
      1.08%  perf_reseau4  [unknown]           [k] 0x7ffffda6
      1.05%  perf_reseau4  [unknown]           [k] 0x7ffffda8
      1.02%  perf_reseau4  [unknown]           [k] 0x7ffffd9a
      1.01%  perf_reseau4  [unknown]           [k] 0x7ffffdb0
      1.00%  perf_reseau4  [unknown]           [k] 0x7ffffd89
      1.00%  perf_reseau4  [unknown]           [k] 0x7ffffd8b
      1.00%  perf_reseau4  [unknown]           [k] 0x7ffffdac


Christophe
