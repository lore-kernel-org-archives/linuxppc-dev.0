Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 77C841A0130
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 05:05:58 +1100 (AEDT)
Date: Sat, 01 Nov 2014 14:05:54 -0400 (EDT)
Message-Id: <20141101.140554.427928361730485371.davem@davemloft.net>
To: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH V4 1/2] mm: Update generic gup implementation to handle
 hugepage directory
From: David Miller <davem@davemloft.net>
In-Reply-To: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aarcange@redhat.com, linux-arch@vger.kernel.org, steve.capper@linaro.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Oct 2014 13:49:44 +0530

> +/*
> + * Some architectures requires a hugepage directory format that is
> + * required to support multiple hugepage sizes. For example
> + * a4fe3ce7699bfe1bd88f816b55d42d8fe1dac655 introduced the same
> + * on powerpc. This allows for a more flexible hugepage pagetable
> + * layout.
> + */

Please don't put commit IDs into the actual code.

If that commit gets backported to -stable or another tree, then this
comment will send someone on a wild goose chase.
