Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Qft84GGrzF35P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2018 23:24:16 +1000 (AEST)
In-Reply-To: <20180628100509.17413-2-fbarrat@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, alastair@au1.ibm.com,
 andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com, clombard@linux.ibm.com,
 felix@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: huyn@mellanox.com
Subject: Re: [v2,
 01/10] Revert "cxl: Add kernel API to allow a context to operate with
 relocate disabled"
Message-Id: <41Qft75SvqzB4Mj@ozlabs.org>
Date: Wed, 11 Jul 2018 23:24:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-28 at 10:05:00 UTC, Frederic Barrat wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove abandonned capi support for the Mellanox CX4.
> The symbol 'cxl_set_translation_mode' is never called, so
> ctx->real_mode is always false.
> 
> This reverts commit 7a0d85d313c2066712e530e668bc02bb741a685c.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c5828150067c47a97f30e690a472e0

cheers
