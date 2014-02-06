Return-Path: <cl@linux.com>
Received: from qmta04.emeryville.ca.mail.comcast.net
 (qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
 by ozlabs.org (Postfix) with ESMTP id 7CAD82C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 04:31:44 +1100 (EST)
Date: Thu, 6 Feb 2014 11:31:40 -0600 (CST)
From: Christoph Lameter <cl@linux.com>
To: David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 1/3] slub: search partial list on numa_mem_id(),
 instead of numa_node_id()
In-Reply-To: <alpine.DEB.2.02.1402060037210.21148@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.10.1402061131070.5348@nuc>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
 <alpine.DEB.2.02.1402060037210.21148@chino.kir.corp.google.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, penberg@kernel.org,
 linux-mm@kvack.org, paulus@samba.org, Anton Blanchard <anton@samba.org>,
 mpm@selenic.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 linuxppc-dev@lists.ozlabs.org, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 6 Feb 2014, David Rientjes wrote:

> I think you'll need to send these to Andrew since he appears to be picking
> up slub patches these days.

I can start managing merges again if Pekka no longer has the time.
