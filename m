Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by ozlabs.org (Postfix) with ESMTP id 90A162C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 06:33:52 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:34111 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6816841Ab3KUTdovDp7i (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Thu, 21 Nov 2013 20:33:44 +0100
Date: Thu, 21 Nov 2013 20:33:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20131121193313.GE13331@linux-mips.org>
References: <1384915853-31006-1-git-send-email-r65037@freescale.com>
 <1384915853-31006-24-git-send-email-r65037@freescale.com>
 <20131121173933.GT10382@linux-mips.org>
 <20131121200804.617d6ae6@skate>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131121200804.617d6ae6@skate>
Cc: Richard Zhu <r65037@freescale.com>, linux-s390@vger.kernel.org,
 linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-mips@linux-mips.org, x86@kernel.org,
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

On Thu, Nov 21, 2013 at 08:08:04PM +0100, Thomas Petazzoni wrote:

> I think this patch was mistakenly sent by Richard Zhu. It is already
> part of mainline since 3.12:

Explains the deja vue ...

  Ralf
