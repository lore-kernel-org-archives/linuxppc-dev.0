Return-Path: <cl@linux.com>
Received: from qmta06.emeryville.ca.mail.comcast.net
 (qmta06.emeryville.ca.mail.comcast.net [76.96.30.56])
 by ozlabs.org (Postfix) with ESMTP id 740BD2C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 02:55:52 +1100 (EST)
Date: Wed, 29 Jan 2014 09:55:47 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: enable CONFIG_HAVE_MEMORYLESS_NODES
In-Reply-To: <20140128183457.GA9315@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1401290955190.23856@nuc>
References: <20140128183457.GA9315@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Matt Mackall <mpm@selenic.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jan 2014, Nishanth Aravamudan wrote:

> Anton Blanchard found an issue with an LPAR that had no memory in Node
> 0. Christoph Lameter recommended, as one possible solution, to use
> numa_mem_id() for locality of the nearest memory node-wise. However,
> numa_mem_id() [and the other related APIs] are only useful if
> CONFIG_HAVE_MEMORYLESS_NODES is set. This is only the case for ia64
> currently, but clearly we can have memoryless nodes on ppc64. Add the
> Kconfig option and define it to be the same value as CONFIG_NUMA.

Well this is trivial but if you need encouragement:

Reviewed-by: Christoph Lameter <cl@linux.com>
