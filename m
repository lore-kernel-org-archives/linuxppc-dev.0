Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Dec 2007 15:06:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: [1/2] Merge dtc upstream source
Message-ID: <20071218040642.GC10348@localhost.localdomain>
References: <20071218040348.GB10348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071218040348.GB10348@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This large patch incorporates a copy of dtc into the kernel source, in
arch/powerpc/boot/dtc-src.  This patch only imports the upstream
sources verbatim, a later patches is needed to actually link it into
the kernel Makefiles and use the embedded code during the kernel
build.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/boot/dtc-src/Makefile.dtc             |   25 
 arch/powerpc/boot/dtc-src/checks.c                 |  750 +++++++
 arch/powerpc/boot/dtc-src/data.c                   |  321 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.l              |  328 +++
 arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped  | 2174 +++++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.c_shipped | 1983 +++++++++++++++++++
 arch/powerpc/boot/dtc-src/dtc-parser.tab.h_shipped |  111 +
 arch/powerpc/boot/dtc-src/dtc-parser.y             |  336 +++
 arch/powerpc/boot/dtc-src/dtc.c                    |  231 ++
 arch/powerpc/boot/dtc-src/dtc.h                    |  269 ++
 arch/powerpc/boot/dtc-src/flattree.c               |  968 +++++++++
 arch/powerpc/boot/dtc-src/fstree.c                 |   94 
 arch/powerpc/boot/dtc-src/livetree.c               |  305 ++
 arch/powerpc/boot/dtc-src/srcpos.c                 |  105 +
 arch/powerpc/boot/dtc-src/srcpos.h                 |   75 
 arch/powerpc/boot/dtc-src/treesource.c             |  275 ++
 arch/powerpc/boot/dtc-src/version_gen.h            |    1 
 17 files changed, 8351 insertions(+)

Patch is too big for the list (224k).  Download from:
	http://ozlabs.org/~dgibson/home/merge-dtc.patch

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
