Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slFPQ0S8QzDsjG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 23:13:14 +1000 (AEST)
In-Reply-To: <1475037298-19188-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhelgaas@google.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v3,1/6] powerpc/eeh: Allow to freeze PE in eeh_pe_set_option()
Message-Id: <3slFPP5wy3z9sBX@ozlabs.org>
Date: Thu, 29 Sep 2016 23:13:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-28-09 at 04:34:53 UTC, Gavin Shan wrote:
> Function eeh_pe_set_option() is used to apply the requested options
> (enable, disable, unfreeze) in EEH virtualization path. The semantics
> of this function isn't complete until freezing is supported.
> 
> This allows to freeze the indicated PE. The new semantics is going to
> be used in PCI surprise hot remove path, to freeze removed PCI devices
> (PE) to avoid unexpected EEH error reporting.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/de5a6622495117ef2e0335d509e917

cheers
