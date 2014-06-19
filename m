Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x235.google.com (mail-qg0-x235.google.com
 [IPv6:2607:f8b0:400d:c04::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DEFA1A00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 00:59:56 +1000 (EST)
Received: by mail-qg0-f53.google.com with SMTP id i50so2222876qgf.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jun 2014 07:59:53 -0700 (PDT)
Date: Thu, 19 Jun 2014 10:59:50 -0400
From: Tejun Heo <htejun@gmail.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Node 0 not necessary for powerpc?
Message-ID: <20140619145950.GG26904@htj.dyndns.org>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
 <20140313164949.GC22247@linux.vnet.ibm.com>
 <20140519182400.GM8941@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1405210915170.7859@gentwo.org>
 <20140521185812.GA5259@htj.dyndns.org>
 <20140521195743.GA5755@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1406091447240.5271@chino.kir.corp.google.com>
 <20140610233157.GB24463@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140610233157.GB24463@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, linux-mm@kvack.org, anton@samba.org,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 10, 2014 at 04:31:57PM -0700, Nishanth Aravamudan wrote:
> > I think what this really wants to do is NODE_DATA(cpu_to_mem(cpu)) and I 
> > thought ppc had the cpu-to-local-memory-node mappings correct?
> 
> Except cpu_to_mem relies on the mapping being defined, but early in
> boot, specifically, it isn't yet (at least not necessarily).

Can't ppc NODE_DATA simply return dummy generic node_data during early
boot?  Populating it with just enough to make early boot work
shouldn't be too hard, right?

Thanks.

-- 
tejun
