Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgeamrelo01.lge.com (lgeamrelo01.lge.com [156.147.1.125])
 by lists.ozlabs.org (Postfix) with ESMTP id 15B5C1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 12:54:16 +1000 (EST)
Date: Mon, 19 May 2014 11:41:40 +0900
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/3] slub: search partial list on numa_mem_id(),
 instead of numa_node_id()
Message-ID: <20140519024140.GD19615@js1304-P5Q-DELUXE>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20140516233735.GH8941@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140516233735.GH8941@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 16, 2014 at 04:37:35PM -0700, Nishanth Aravamudan wrote:
> On 06.02.2014 [17:07:04 +0900], Joonsoo Kim wrote:
> > Currently, if allocation constraint to node is NUMA_NO_NODE, we search
> > a partial slab on numa_node_id() node. This doesn't work properly on the
> > system having memoryless node, since it can have no memory on that node and
> > there must be no partial slab on that node.
> > 
> > On that node, page allocation always fallback to numa_mem_id() first. So
> > searching a partial slab on numa_node_id() in that case is proper solution
> > for memoryless node case.
> > 
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> 
> Joonsoo, would you send this one on to Andrew?

Hello,

Okay. I will do it.

Thanks.
