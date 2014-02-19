Return-Path: <cl@linux.com>
Received: from qmta01.emeryville.ca.mail.comcast.net
 (qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
 by ozlabs.org (Postfix) with ESMTP id 1F8642C00C1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 03:11:40 +1100 (EST)
Date: Wed, 19 Feb 2014 10:11:33 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 2/3] topology: support node_numa_mem() for determining
 the fallback node
In-Reply-To: <20140218222242.GA10844@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1402191010250.11318@nuc>
References: <alpine.DEB.2.10.1402071245040.20246@nuc>
 <20140210191321.GD1558@linux.vnet.ibm.com> <20140211074159.GB27870@lge.com>
 <20140213065137.GA10860@linux.vnet.ibm.com> <20140217070051.GE3468@lge.com>
 <alpine.DEB.2.10.1402181051560.1291@nuc>
 <20140218172832.GD31998@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181356120.2910@nuc>
 <20140218210923.GA28170@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1402181547210.3973@nuc>
 <20140218222242.GA10844@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Feb 2014, Nishanth Aravamudan wrote:

> the performance impact of the underlying NUMA configuration. I guess we
> could special-case memoryless/cpuless configurations somewhat, but I
> don't think there's any reason to do that if we can make memoryless-node
> support work in-kernel?

Well we can make it work in-kernel but it always has been a bit wacky (as
is the idea of numa "memory" nodes without memory).
