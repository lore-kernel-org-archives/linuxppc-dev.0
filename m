Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7250DDDB2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 03:14:14 +1100 (EST)
Date: Mon, 9 Mar 2009 11:14:09 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'merge'
Message-ID: <Pine.LNX.4.64.0903091113300.28695@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/configs/linkstation_defconfig       |   36 +++++++++++++--------
 arch/powerpc/configs/storcenter_defconfig        |   35 +++++++++++++--------
 arch/powerpc/platforms/embedded6xx/linkstation.c |   38 -----------------------
 arch/powerpc/platforms/embedded6xx/storcenter.c  |   32 -------------------
 4 files changed, 44 insertions(+), 97 deletions(-)

Guennadi Liakhovetski (1):
      powerpc: fix linkstation and storcenter compilation breakage
