Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E90351A004C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:15:00 +1100 (AEDT)
Date: Fri, 12 Feb 2016 13:52:38 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 02/29] powerpc/mm: Split pgtable types to separate
 header
Message-ID: <20160212025238.GC13831@oak.ozlabs.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1454923241-6681-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454923241-6681-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 02:50:14PM +0530, Aneesh Kumar K.V wrote:
> We remove real_pte_t out of STRICT_MM_TYPESCHECK. We will later add
> a radix variant that is big endian
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

It looks like most of what this patch does is move a bunch of
definitions from page.h to a new pgtable-types.h.  What is the
motivation for this?  Is the code identical (pure code movement) or do
you make changes along the way, and if so, what and why?

What exactly are you doing with real_pte_t and why?

Paul.
