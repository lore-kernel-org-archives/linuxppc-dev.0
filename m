Return-Path: <glikely@secretlab.ca>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id EC00EDE1A0
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 15:59:18 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so769975qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 22:59:14 -0700 (PDT)
MIME-Version: 1.0
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 16 Apr 2009 23:58:59 -0600
Message-ID: <fa686aa40904162258i450c86e9k303933d41405c89b@mail.gmail.com>
Subject: Please pull merge branch from git.secretlab.ca
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben/Paul,

Here are some fixups and documentation updates for 2.6.30

The following changes since commit 0882e8dd3aad33eca41696d463bb896e6c8817eb:
  Linus Torvalds (1):
        Linux 2.6.30-rc2

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 merge

Anton Vorontsov (1):
      powerpc/5200: Bring the legacy fsl_spi_platform_data hooks back

Grant Likely (1):
      powerpc/5200: Add FLASH nodes to lite5200 device tree

Stefan Roese (2):
      powerpc/of-device-tree: Factor MTD physmap bindings out of
booting-without-of
      powerpc/device-tree: Document MTD nodes with multiple "reg" tuples

 Documentation/powerpc/booting-without-of.txt       |   89 +++-----------------
 Documentation/powerpc/dts-bindings/mtd-physmap.txt |   80 ++++++++++++++++++
 arch/powerpc/boot/dts/lite5200b.dts                |   39 +++++++++
 include/linux/fsl_devices.h                        |    4 +
 4 files changed, 135 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mtd-physmap.txt


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
