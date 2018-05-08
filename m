Return-Path: <srs0=oh4o=h3=intel.com=dave.hansen@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gQNL6y9hzF1nM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:45:54 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40gQNL4qhMz8t79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 02:45:54 +1000 (AEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40gQNK2gNKz9s27
 for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2018 02:45:52 +1000 (AEST)
Subject: Re: [PATCH 5/8] x86/pkeys: Move vma_pkey() into asm/pkeys.h
To: Michael Ellerman <mpe@ellerman.id.au>, linuxram@us.ibm.com
References: <20180508145948.9492-1-mpe@ellerman.id.au>
 <20180508145948.9492-6-mpe@ellerman.id.au>
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f9240079-2ff2-9d3f-ba15-fefe65c67779@intel.com>
Date: Tue, 8 May 2018 09:45:46 -0700
MIME-Version: 1.0
In-Reply-To: <20180508145948.9492-6-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/2018 07:59 AM, Michael Ellerman wrote:
> Move the last remaining pkey helper, vma_pkey() into asm/pkeys.h

Fine with me, as long as it compiles. :)

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
