Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 0/2]  powerpc: Open PIC binding and "pic-no-reset"
Date: Fri, 25 Feb 2011 15:59:35 -0600
Message-Id: <1298671177-19572-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Hollis Blanchard <hollis_blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch set provides a binding for Open PIC and implements support for
a new property, specified by that binding, called "pic-no-reset".

v4 - Per Ben's feedback the protected sources implementation was left
     completely intact.  As such, the DTS cleanup and "protected-sources"
     removal patches were dropped.

v3 - the Open PIC binding was changed to be more consistent with existing
     bindings, several DTS files were cleaned up, "no-reset" was changed to
     "pic-no-reset", and a check to treat "protected-sources" as a synonym for
     "pic-no-reset" was added.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
Cc: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Meador Inge (2):
  powerpc: document the Open PIC device tree binding
  powerpc: make MPIC honor the "pic-no-reset" device tree property

 Documentation/powerpc/dts-bindings/open-pic.txt |   98 +++++++++++++++++++++++
 arch/powerpc/include/asm/mpic.h                 |    6 ++
 arch/powerpc/sysdev/mpic.c                      |   67 ++++++++++++----
 3 files changed, 155 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/open-pic.txt
