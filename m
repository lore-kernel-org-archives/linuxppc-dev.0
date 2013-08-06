Return-Path: <000001405421b036-0b2994fa-3dd8-4ce7-995c-81660d804803-000000@amazonses.com>
Received: from a193-30.smtp-out.amazonses.com (a193-30.smtp-out.amazonses.com
 [199.255.193.30]) by ozlabs.org (Postfix) with ESMTP id 8A79E2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 01:06:59 +1000 (EST)
Date: Tue, 6 Aug 2013 14:57:08 +0000
From: Christoph Lameter <cl@gentwo.org>
To: Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
In-Reply-To: <5200A29C.9060702@gmail.com>
Message-ID: <000001405421b036-0b2994fa-3dd8-4ce7-995c-81660d804803-000000@email.amazonses.com>
References: <51F8F827.6020108@gmail.com>
 <alpine.DEB.2.02.1307310858150.30572@gentwo.org>
 <alpine.DEB.2.02.1307311015320.30997@gentwo.org>
 <000001403567762a-60a27288-f0b2-4855-b88c-6a6f21ec537c-000000@email.amazonses.com>
 <51F93C64.4090601@gmail.com>
 <0000014035b06a9d-e8b10680-e321-4d3b-95a8-0833fa3fb7c9-000000@email.amazonses.com>
 <5200A29C.9060702@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dedekind1@gmail.com, Mel Gorman <mel@csn.ul.ie>, dwmw2@infradead.org,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Aug 2013, Wladislav Wiebe wrote:

> ok, just saw in slab/for-linus branch that those stuff is reverted again..

No that was only for the 3.11 merge by Linus. The 3.12 patches have not
been put into pekkas tree.
