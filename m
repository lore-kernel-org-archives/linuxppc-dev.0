Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2l0V4hsGzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:19:22 +1000 (AEST)
Date: Wed, 12 Apr 2017 10:19:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH 3/9] powerpc/mm: Add _PAGE_DEVMAP for ppc64.
Message-ID: <20170412101922.572b59ca@canb.auug.org.au>
In-Reply-To: <20170411174233.21902-4-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-4-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

On Wed, 12 Apr 2017 03:42:27 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Add a _PAGE_DEVMAP bit for PTE and DAX PMD entires. PowerPC doesn't
> currently support PUD faults so we haven't extended it to the PUD
> level.
> 
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

This needs Aneesh's Signed-off-by.

-- 
Cheers,
Stephen Rothwell
