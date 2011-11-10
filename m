Return-Path: <ralf@linux-mips.org>
Received: from linux-mips.org
 (6.7.d.7.e.9.6.e.9.3.9.f.e.8.9.4.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:3ea:0:498e:f939:e69e:7d76])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 406DDB6F77
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 22:41:45 +1100 (EST)
Date: Thu, 10 Nov 2011 11:41:15 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/5] treewide: Remove useless NORET_TYPE macro and uses
Message-ID: <20111110114115.GA21453@linux-mips.org>
References: <cover.1320917551.git.joe@perches.com>
 <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e69163f6245513b05d5d21c2f57b916931ad5bff.1320917557.git.joe@perches.com>
Cc: Andrew Morton <akpm@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 Peter Zijlstra <peterz@infradead.org>, linux-s390@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Chris Metcalf <cmetcalf@tilera.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
 Haavard Skinnemoen <hskinnemoen@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 01:41:44AM -0800, Joe Perches wrote:

>  arch/mips/include/asm/ptrace.h         |    2 +-
>  arch/mips/kernel/traps.c               |    2 +-

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
