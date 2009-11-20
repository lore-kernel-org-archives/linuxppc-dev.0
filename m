Return-Path: <nfont@austin.ibm.com>
Message-ID: <4B06AF33.1000400@austin.ibm.com>
Date: Fri, 20 Nov 2009 09:01:07 -0600
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
Subject: [PATCH 0/4 v2] Merge OF dynamic patches
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set of patches merges the common dynamic device tree
updating routines of_attach_node() and of_detach_node() to
drivers/of/of_dynamic.c.

Built and tested on powerpc, I have no access to build/test
this on microblaze.

-Nathan Fontenot
---

1/4 - Merge of_attach_node
2/4 - Merge of_detach_node
3/4 - Makefile/Kconfig updates
4/4 - Update powerpc/pseries to include of_dynamic.h

 arch/microblaze/Kconfig                   |    1 
 arch/microblaze/include/asm/prom.h        |    4 -
 arch/microblaze/kernel/prom.c             |   59 -----------------------
 arch/powerpc/Kconfig                      |    1 
 arch/powerpc/include/asm/prom.h           |    4 -
 arch/powerpc/kernel/prom.c                |   59 -----------------------
 arch/powerpc/platforms/pseries/reconfig.c |    1 
 drivers/of/Kconfig                        |    4 +
 drivers/of/Makefile                       |    1 
 drivers/of/of_dynamic.c                   |   75 ++++++++++++++++++++++++++++++
 include/linux/of_dynamic.h                |   27 ++++++++++
 11 files changed, 110 insertions(+), 126 deletions(-)
