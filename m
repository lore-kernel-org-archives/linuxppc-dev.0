Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BCC6DDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 17:14:15 +1000 (EST)
Date: Fri, 17 Aug 2007 02:14:29 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to arch/powerpc
	that we need
In-Reply-To: <Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To build arch/powerpc without including asm-ppc/ we need these files
in asm-powerpc/

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/8xx_immap.h   |  564 +++++++++++++++++
 include/asm-powerpc/commproc.h    |  692 ++++++++++++++++++++
 include/asm-powerpc/cpm2.h        | 1248 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/gg2.h         |   61 ++
 include/asm-powerpc/highmem.h     |  135 ++++
 include/asm-powerpc/hydra.h       |  102 +++
 include/asm-powerpc/immap_cpm2.h  |  648 +++++++++++++++++++
 include/asm-powerpc/kgdb.h        |   57 ++
 include/asm-powerpc/m8260_pci.h   |  187 ++++++
 include/asm-powerpc/mpc10x.h      |  180 ++++++
 include/asm-powerpc/mpc52xx_psc.h |  191 ++++++
 11 files changed, 4065 insertions(+), 0 deletions(-)
 create mode 100644 include/asm-powerpc/8xx_immap.h
 create mode 100644 include/asm-powerpc/commproc.h
 create mode 100644 include/asm-powerpc/cpm2.h
 create mode 100644 include/asm-powerpc/gg2.h
 create mode 100644 include/asm-powerpc/highmem.h
 create mode 100644 include/asm-powerpc/hydra.h
 create mode 100644 include/asm-powerpc/immap_cpm2.h
 create mode 100644 include/asm-powerpc/kgdb.h
 create mode 100644 include/asm-powerpc/m8260_pci.h
 create mode 100644 include/asm-powerpc/mpc10x.h
 create mode 100644 include/asm-powerpc/mpc52xx_psc.h

[patch removed since I was just copying the asm-ppc variants to
asm-powerpc]

- k
