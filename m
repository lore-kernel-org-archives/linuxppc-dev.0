Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by ozlabs.org (Postfix) with ESMTP id 5723F2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 04:55:57 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:33627 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6867243Ab3KURkBobykT (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Thu, 21 Nov 2013 18:40:01 +0100
Date: Thu, 21 Nov 2013 18:39:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Richard Zhu <r65037@freescale.com>
Subject: Re: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20131121173933.GT10382@linux-mips.org>
References: <1384915853-31006-1-git-send-email-r65037@freescale.com>
 <1384915853-31006-24-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384915853-31006-24-git-send-email-r65037@freescale.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>,
 Jason Cooper <jason@lakedaemon.net>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-mips@linux-mips.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chris Metcalf <cmetcalf@tilera.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 10:50:43AM +0800, Richard Zhu wrote:

Looking good,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

Nevertheless I'd again like to express that I'm not that fond of of the
increasing number of weak functions in the kernel.  In the old days
things were such that when an a platform didn't provice a platform hook
or enable a default hook function, one would get a build error - an
unmistakable sign to the maintainer that something needs attention.
Weak functions mean default functions may result in subtly incorrect
operation.  Been there, got bitten.

  Ralf
