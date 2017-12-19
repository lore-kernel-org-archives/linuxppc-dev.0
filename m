Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1Fsw4KJvzDwNm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:24:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] PCI: Add #defines for Completion Timeout Disable feature
In-Reply-To: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20171215225711.176712.65146.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 19 Dec 2017 22:24:20 +1100
Message-ID: <871sjr9d0b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Add #defines for the Completion Timeout Disable feature and use them.  No
> functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c |    6 +++---
>  include/uapi/linux/pci_regs.h                |    2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
