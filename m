Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B34031A0048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:15:00 +1100 (AEDT)
Date: Fri, 12 Feb 2016 13:49:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 01/29] powerpc/mm: add _PAGE_HASHPTE similar to 4K hash
Message-ID: <20160212024906.GB13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454923241-6681-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 02:50:13PM +0530, Aneesh Kumar K.V wrote:
> Not really needed. But this brings it back to as it was before

If it's not really needed, what's the motivation for putting this
patch in?  You need to explain where you are heading with this patch.

> Check this
> 41743a4e34f0777f51c1cf0675b91508ba143050

The SHA1 is useful, but you need to be more explicit - something like

"This partially reverts commit 41743a4e34f0 ("powerpc: Free a PTE bit
on ppc64 with 64K pages", 2008-06-11)."

Paul.
