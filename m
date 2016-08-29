Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sN7x20vzLzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 21:00:53 +1000 (AEST)
Subject: [PATCH 0/5] PowerPC: Fine-tuning for three function implementations
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
To: linuxppc-dev@lists.ozlabs.org, Adam Buchbinder
 <adam.buchbinder@gmail.com>, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <scottwood@freescale.com>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4c0babe9-0192-1a99-7ff3-5028cc69325d@users.sourceforge.net>
Date: Mon, 29 Aug 2016 13:00:13 +0200
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Aug 2016 11:44:22 +0200

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (5):
  Use kmalloc_array() in mpic_init()
  Use kmalloc_array() in ppc4xx_setup_msi_irqs()
  Use kmalloc_array() in hsta_msi_probe()
  Rename jump labels in hsta_msi_probe()
  Move three assignments in hsta_msi_probe()

 arch/powerpc/sysdev/mpic.c            |  5 +++--
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c | 26 +++++++++++++-------------
 arch/powerpc/sysdev/ppc4xx_msi.c      |  4 +++-
 3 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.9.3
