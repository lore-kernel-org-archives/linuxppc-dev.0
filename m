Return-Path: <ralf@linux-mips.org>
Received: from linux-mips.org
 (6.7.d.7.e.9.6.e.9.3.9.f.e.8.9.4.0.0.0.0.a.e.3.0.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:3ea:0:498e:f939:e69e:7d76])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6F72FB6F75
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 23:21:44 +1100 (EST)
Date: Thu, 10 Nov 2011 11:16:04 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to
 __noreturn
Message-ID: <20111110111604.GB1580@linux-mips.org>
References: <cover.1320917551.git.joe@perches.com>
 <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Cc: Andrew Morton <akpm@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
 David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux390@de.ibm.com,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 linux-s390@vger.kernel.org, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org, linux-am33-list@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 01:41:45AM -0800, Joe Perches wrote:

> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.

Subject and here: s/ATTRIB_NORETURN/ATTRIB_NORET/

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/ia64/kernel/machine_kexec.c       |    2 +-
>  arch/m68k/amiga/config.c               |    2 +-
>  arch/mips/include/asm/ptrace.h         |    2 +-
>  arch/mips/kernel/traps.c               |    2 +-

For the MIPS bits:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
