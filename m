Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 19 Sep 2005 23:10:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050919231051.28fcdf30.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/6] powerpc: merge arch/ppc*/oprofile directories
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches merge the arch/ppc*/oprofile directories into arch/powerpc.

 arch/powerpc/oprofile/Kconfig              |   23 ++
 arch/powerpc/oprofile/Makefile             |   11 +
 arch/powerpc/oprofile/common.c             |  227 +++++++++++++++++++--
 arch/powerpc/oprofile/op_model_fsl_booke.c |  183 +++++++++++++++++
 arch/powerpc/oprofile/op_model_power4.c    |  309 ++++++++++++++++++++++++++++
 arch/powerpc/oprofile/op_model_rs64.c      |  218 ++++++++++++++++++++
 arch/ppc/Kconfig                           |    2
 arch/ppc/Makefile                          |    2
 arch/ppc/kernel/perfmon.c                  |   10
 arch/ppc/oprofile/Kconfig                  |   23 --
 arch/ppc/oprofile/Makefile                 |   16 -
 arch/ppc/oprofile/common.c                 |  165 ---------------
 arch/ppc/oprofile/op_impl.h                |   47 ----
 arch/ppc/oprofile/op_model_fsl_booke.c     |  188 -----------------
 arch/ppc64/Kconfig                         |    2
 arch/ppc64/Makefile                        |    2
 arch/ppc64/oprofile/Kconfig                |   23 --
 arch/ppc64/oprofile/Makefile               |   11 -
 arch/ppc64/oprofile/common.c               |  147 -------------
 arch/ppc64/oprofile/op_model_power4.c      |  311 -----------------------------
 arch/ppc64/oprofile/op_model_rs64.c        |  220 --------------------
 include/asm-powerpc/oprofile_impl.h        |  123 +++++++++++
 include/asm-ppc/perfmon.h                  |    6
 include/asm-ppc64/cputable.h               |    4
 include/asm-ppc64/oprofile_impl.h          |  121 -----------
 25 files changed, 1108 insertions(+), 1286 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
