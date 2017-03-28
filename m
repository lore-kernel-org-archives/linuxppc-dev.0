Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsfgN5TwXzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 16:33:04 +1100 (AEDT)
Date: Tue, 28 Mar 2017 16:32:40 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 09/10] powerpc/mm: Lower the max real address to 53 bits
Message-ID: <20170328053240.cp4qlh3bphaxikxr@oak.ozlabs.ibm.com>
References: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1490117400-9891-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490117400-9891-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 21, 2017 at 10:59:59PM +0530, Aneesh Kumar K.V wrote:
> Max value supported by hardware is 51 bits address. Radix page table define
> a slot of 57 bits for future expansion. We restrict the value supported in
> linux kernel 53 bits, so that we can use the bits between 57-53 for storing
> hash linux page table bits. This is done in the next patch.
> 
> This will free up the software page table bits to be used for features
> that are needed for both hash and radix. The current hash linux page table
> format doesn't have any free software bits. Moving hash linux page table
> specific bits to top of RPN field free up the software bits for other purpose.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
