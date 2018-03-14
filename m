Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RG36qNgzDr2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:39 +1100 (AEDT)
In-Reply-To: <1513732229-10066-2-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [1/1] vas: vas_window_init_dbgdir: fix order of cleanup.
Message-Id: <401RG31qd3z9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-20 at 01:10:29 UTC, Sukadev Bhattiprolu wrote:
> Fix the order of cleanup to ensure we free the name buffer in case
> of an error creating 'hvwc' or 'info' files.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1373cc31074dff09419d616c2ce911

cheers
