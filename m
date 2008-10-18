Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 1DAD2DDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Oct 2008 16:18:16 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so808397rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 22:18:15 -0700 (PDT)
Message-ID: <fa686aa40810172218i209c1a6cpec63f620cbb5917d@mail.gmail.com>
Date: Fri, 17 Oct 2008 23:18:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>
Subject: Please pull linux-2.6-mpc52xx
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following changes since commit 6dc6472581f693b5fc95aebedf67b4960fb85cf0:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin'

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx merge

Grant Likely (1):
      powerpc/52xx: Make cuImage more robust in locating immr node.

Wolfram Sang (2):
      powerpc/mpc5200: Don't touch pipelining for MPC5200B
      powerpc/mpc5200: Refactor FEC mdio read/write routines

 arch/powerpc/boot/cuboot-52xx.c              |    4 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 ++-
 drivers/net/fec_mpc52xx_phy.c                |   55 ++++++++++---------------
 3 files changed, 31 insertions(+), 35 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
