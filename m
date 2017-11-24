Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrtj4vwZzDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:37 +1100 (AEDT)
In-Reply-To: <20171120191247.GD17769@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-team@fedoraproject.org, Michael Neuling <mikey@neuling.org>,
 Josh Boyer <jwboyer@fedoraproject.org>, linux-kernel@vger.kernel.org,
 nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org
Subject: Re: powerpc/vas, export chip_to_vas_id()
Message-Id: <3yjrth6C1Wz9sRg@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-11-20 at 19:12:48 UTC, Sukadev Bhattiprolu wrote:
> >From 958f8db089f4b89407fc4b89bccd3eaef585aa96 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Mon, 20 Nov 2017 12:53:15 -0600
> Subject: [PATCH 1/1] powerpc/vas, export chip_to_vas_id()
> 
> Export the symbol chip_to_vas_id() to fix a build failure when
> CONFIG_CRYPTO_DEV_NX_COMPRESS_POWERNV=m.
> 
> Reported-by: Haren Myneni <hbabu@us.ibm.com>
> Reported-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/62b49c42107efd973edffc75f4f874

cheers
