Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32B13DDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:31:09 +1100 (EST)
Date: Mon, 15 Dec 2008 14:31:04 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'next' branch
Message-ID: <Pine.LNX.4.64.0812151430430.29867@blarg.am.freescale.net>
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

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/dts/mpc8572ds.dts |   16 ++++++++--------
 arch/powerpc/include/asm/cputable.h |   15 ++++++++-------
 2 files changed, 16 insertions(+), 15 deletions(-)

Benjamin Herrenschmidt (1):
      powerpc: Fix bogus cache flushing on all 40x and BookE processors v2

Kumar Gala (1):
      powerpc/85xx: Fix compile issues with mpc8572ds.dts
