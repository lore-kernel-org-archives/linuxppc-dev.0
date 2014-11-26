Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5060B1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 15:07:51 +1100 (AEDT)
In-Reply-To: <1416868020-4129-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/3] powerpc/powernv: Replace OPAL_DEASSERT_RESET with
 EEH_RESET_DEACTIVATE
Message-Id: <20141126040751.3649B14017B@ozlabs.org>
Date: Wed, 26 Nov 2014 15:07:51 +1100 (AEDT)
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-24-11 at 22:26:59 UTC, Gavin Shan wrote:
> The flag passed to ioda_eeh_phb_reset() should be EEH_RESET_DEACTIVATE,
> which is translated to OPAL_DEASSERT_RESET or something else by the
> EEH backend accordingly.
> 
> The patch replaces OPAL_DEASSERT_RESET with EEH_RESET_DEACTIVATE for
> ioda_eeh_phb_reset().

What is the symptom? Does it not work at all or is it just a cosmetic issue?
ie. should I send this to Linus ASAP or can it wait for the next release.

Looks like this went in as 361f2a2a1536 ("powrpc/powernv: Reset PHB in kdump
kernel") in 3.16. Should it go to stable?

cheers
