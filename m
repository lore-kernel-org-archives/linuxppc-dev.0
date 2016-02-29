Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8380E1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 13:36:28 +1100 (AEDT)
Message-ID: <1456713374.32505.55.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/2] powerpc/mm: Replace _PAGE_USER with _PAGE_PRIV
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 Feb 2016 13:36:14 +1100
In-Reply-To: <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1456456850-2679-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456456850-2679-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-02-26 at 08:50 +0530, Aneesh Kumar K.V wrote:
> _PAGE_PRIV means the page can be accessed only by kernel. This is
> done
> to keep pte bits similar to PowerISA 3.0 radix PTE format. User
> pages are now makred by clearing _PAGE_PRIV bit.

Very minor nit: It's not clear that PRIV means PRIVILEGED (rather than
PRIVATE). Can you spell it out completely instead ? I like things being
self-describing ;-)

Cheers,
Ben.
