Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0Y093Rm3zDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 08:40:25 +1000 (AEST)
In-Reply-To: <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: robh+dt@kernel.org, paulus@samba.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, grant.likely@linaro.org,
 frowand.list@gmail.com
Subject: Re: [2/2] powerpc: Update of_remove_property() call sites to remove
 null checking
Message-Id: <3r0Y092fNPz9t5T@ozlabs.org>
Date: Thu,  5 May 2016 08:40:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-28-04 at 05:34:55 UTC, Suraj Jitindar Singh wrote:
> After obtaining a property from of_find_property() and before calling
> of_remove_property() most code checks to ensure that the property
> returned from of_find_property() is not null. The previous patch
> moved this check to the start of the function of_remove_property() in
> order to avoid the case where this check isn't done and a null value is
> passed. This ensures the check is always conducted before taking locks
> and attempting to remove the property. Thus it is no longer necessary
> to perform a check for null values before invoking of_remove_property().
> 
> Update of_remove_property() call sites in order to remove redundant
> checking for null property value as check is now performed within the
> of_remove_property function().
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/676669b666574a23f7bd62870c

cheers
