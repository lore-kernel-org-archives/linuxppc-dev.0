Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD7302C0087
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jun 2013 17:20:47 +1000 (EST)
Message-ID: <1372490434.18612.64.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 29 Jun 2013 17:20:34 +1000
In-Reply-To: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan.Chen@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-28 at 21:10 +0800, Gavin Shan wrote:
> The issue was introduced by commit 37f02195 ("powerpc/pci: fix
> PCI-e devices rescan issue on powerpc platform"). The field

That "fix" caused more problems than it solved. There's a better
approach floating around that I will merge eventually next week.

Cheers,
Ben.
