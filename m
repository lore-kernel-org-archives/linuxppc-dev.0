Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96764DDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 18:43:18 +1100 (EST)
Date: Fri, 31 Oct 2008 02:43:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' (updated)(for 2.6.28)
Message-ID: <Pine.LNX.4.64.0810310242380.12545@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="330304082-1714446105-1225438991=:12545"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--330304082-1714446105-1225438991=:12545
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/mpc8313erdb.dts            |   39 -----------------------
 arch/powerpc/configs/linkstation_defconfig       |   11 ++----
 arch/powerpc/platforms/embedded6xx/linkstation.c |   14 ++++++++
 3 files changed, 19 insertions(+), 45 deletions(-)

Guennadi Liakhovetski (1):
      powerpc: fix i2c on PPC linkstation / kurobox machines

Mike Dyer (1):
      powerpc: Remove duplicate DMA entry from mpc8313erdb device tree

Rogério Brito (2):
      powerpc: compile kernel for linkstations optimized for size
      powerpc: enable heap randomization for linkstations

--330304082-1714446105-1225438991=:12545--
