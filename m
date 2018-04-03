Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5t2WJ8zF29C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:46 +1000 (AEST)
In-Reply-To: <20180402073337.22568-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [V2] powerpc: Fix oops due to wrong access of lppaca on non
 virtualized platform
Message-Id: <40Fv5s5VLKz9s0q@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-02 at 07:33:37 UTC, "Aneesh Kumar K.V" wrote:
> Commit 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not
> virtualized") removed allocation of lppaca on non virtualized platform. But with
> CONFIG_PPC_SPLPAR enabled, we do access lppaca non-virtualized platform in some
> code paths.
> 
> Fix this but adding runtime check for virtualized platform.
> 
> Fixes: 8e0b634b1327 ("powerpc/64s: Do not allocate lppaca if we are not virtualized")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a6201da34ff9366680e97392efd06a

cheers
