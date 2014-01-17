Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D67112C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 00:57:17 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 17 Jan 2014 11:57:11 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A0C011DC005D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 08:57:08 -0500 (EST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0HDuZDm53411968
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:56:36 -0200
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0HDv7Gl017813
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 11:57:07 -0200
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] Fixes for PCI-E link speed
Date: Fri, 17 Jan 2014 11:56:50 -0200
Message-Id: <1389967012-7774-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These two patches fix problems on the PCI-E link speed detection.
The first one fixes a regression and adds some improvements on the
code, and the second one adds definitions for Gen3 speeds.

Kleber Sacilotto de Souza (2):
  powerpc/pseries: fix regression on PCI link speed
  powerpc/pseries: add Gen3 definitions for PCIE link speed

 arch/powerpc/platforms/pseries/pci.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)
