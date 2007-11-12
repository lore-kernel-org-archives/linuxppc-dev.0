Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/4] Merge dtc and libfdt upstream source
In-Reply-To: <20071112041126.GB2047@localhost.localdomain>
Message-Id: <20071112041524.C6C5FDDED2@ozlabs.org>
Date: Mon, 12 Nov 2007 15:15:24 +1100 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This very large patch incorporates a copy of dtc (including libfdt)
into the kernel source, in arch/powerpc/boot/dtc-src.  This patch only
imports the upstream sources verbatim, later patches are needed to
actually link it into the kernel Makefiles and use the embedded code
during the kernel build.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/boot/dtc-src/Makefile.dtc             |   25 
 arch/powerpc/boot/dtc-src/checks.c                 |  460 ++++
 arch/powerpc/boot/dtc-src/data.c                   |  351 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.l              |  341 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped  | 2184 +++++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped | 1925 ++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped |  110 +
 arch/powerpc/boot/dtc-src/dtc-parser.y             |  304 ++
 arch/powerpc/boot/dtc-src/dtc.c                    |  240 ++
 arch/powerpc/boot/dtc-src/dtc.h                    |  253 ++
 arch/powerpc/boot/dtc-src/flattree.c               |  959 +++++++++
 arch/powerpc/boot/dtc-src/fstree.c                 |   94 
 arch/powerpc/boot/dtc-src/libfdt/Makefile.libfdt   |   14 
 arch/powerpc/boot/dtc-src/libfdt/fdt.c             |  156 +
 arch/powerpc/boot/dtc-src/libfdt/fdt.h             |   60 
 arch/powerpc/boot/dtc-src/libfdt/fdt_ro.c          |  562 +++++
 arch/powerpc/boot/dtc-src/libfdt/fdt_rw.c          |  447 ++++
 arch/powerpc/boot/dtc-src/libfdt/fdt_strerror.c    |   96 
 arch/powerpc/boot/dtc-src/libfdt/fdt_sw.c          |  258 ++
 arch/powerpc/boot/dtc-src/libfdt/fdt_wip.c         |  144 +
 arch/powerpc/boot/dtc-src/libfdt/libfdt.h          |  593 +++++
 arch/powerpc/boot/dtc-src/libfdt/libfdt_internal.h |   89 
 arch/powerpc/boot/dtc-src/livetree.c               |  350 +++
 arch/powerpc/boot/dtc-src/srcpos.c                 |  105 +
 arch/powerpc/boot/dtc-src/srcpos.h                 |   75 
 arch/powerpc/boot/dtc-src/treesource.c             |  236 ++
 arch/powerpc/boot/dtc-src/version_gen.h            |    1 
 27 files changed, 10432 insertions(+)

Much too big for the list.  Full patch at:
	http://ozlabs.org/~dgibson/home/merge-dtc.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
