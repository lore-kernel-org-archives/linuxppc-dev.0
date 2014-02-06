Return-Path: <cl@linux.com>
Received: from qmta10.emeryville.ca.mail.comcast.net
 (qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
 by ozlabs.org (Postfix) with ESMTP id E26EA2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 04:26:20 +1100 (EST)
Date: Thu, 6 Feb 2014 11:26:15 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [RFC PATCH 1/3] slub: search partial list on numa_mem_id(),
 instead of numa_node_id()
In-Reply-To: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <alpine.DEB.2.10.1402061126000.5348@nuc>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Feb 2014, Joonsoo Kim wrote:

> Currently, if allocation constraint to node is NUMA_NO_NODE, we search
> a partial slab on numa_node_id() node. This doesn't work properly on the
> system having memoryless node, since it can have no memory on that node and
> there must be no partial slab on that node.
>
> On that node, page allocation always fallback to numa_mem_id() first. So
> searching a partial slab on numa_node_id() in that case is proper solution
> for memoryless node case.

Acked-by: Christoph Lameter <cl@linux.com>
