Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 7B817DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:18:52 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [trivial] use named structure member initializers for pci_ops
	structures
Date: Thu,  9 Aug 2007 14:18:35 -0500
Message-Id: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This series converts all pci_ops structures in arch/powerpc to named
member initializers, in accordance with prevailing practice in the
kernel.  No behavioral or otherwise stylistic changes.


 arch/powerpc/kernel/pci_32.c             |    4 ++--
 arch/powerpc/kernel/rtas_pci.c           |    4 ++--
 arch/powerpc/platforms/52xx/efika.c      |    4 ++--
 arch/powerpc/platforms/celleb/pci.c      |    4 ++--
 arch/powerpc/platforms/celleb/scc_epci.c |    4 ++--
 arch/powerpc/platforms/chrp/pci.c        |    8 ++++----
 arch/powerpc/platforms/maple/pci.c       |   12 ++++++------
 arch/powerpc/platforms/pasemi/pci.c      |    4 ++--
 arch/powerpc/platforms/powermac/pci.c    |   16 ++++++++--------
 arch/powerpc/sysdev/indirect_pci.c       |    4 ++--
 arch/powerpc/sysdev/tsi108_pci.c         |    4 ++--
 11 files changed, 34 insertions(+), 34 deletions(-)
