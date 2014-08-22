Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F0CAF1A007B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 06:32:26 +1000 (EST)
Date: Fri, 22 Aug 2014 13:32:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/4] Improve slab consumption with memoryless nodes
Message-Id: <20140822133222.d3079dcd85ef1f5d1b4093ed@linux-foundation.org>
In-Reply-To: <20140822011011.GF13999@linux.vnet.ibm.com>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
 <20140822011011.GF13999@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 21 Aug 2014 18:10:11 -0700 Nishanth Aravamudan <nacc@linux.vnet.ibm.com> wrote:

> I know kernel summit is going on, so I'll be patient, but was just
> curious if anyone had any further comments other than Christoph's on the
> naming.

Nope.  Please make a decision on the naming, refresh, retest and resend
and I'll get the patches queued up for review and testing.
