Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD51BDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 14:11:14 +1100 (EST)
Date: Tue, 28 Oct 2008 22:11:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge' branch
Message-ID: <Pine.LNX.4.64.0810282210560.5379@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="330304082-1098012754-1225249850=:5379"
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

--330304082-1098012754-1225249850=:5379
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/configs/linkstation_defconfig       |   11 +++++------
 arch/powerpc/platforms/embedded6xx/linkstation.c |   14 ++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

Guennadi Liakhovetski (1):
      powerpc: fix i2c on PPC linkstation / kurobox machines

Rogério Brito (2):
      powerpc: compile kernel for linkstations optimized for size
      powerpc: enable heap randomization for linkstations

--330304082-1098012754-1225249850=:5379--
