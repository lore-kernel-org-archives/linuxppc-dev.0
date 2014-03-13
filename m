Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F3CB2C018A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 03:50:11 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 13 Mar 2014 10:50:09 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id E1F85C90041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 12:50:04 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2DGo8JM6816226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 16:50:08 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2DGo72E030720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 12:50:08 -0400
Date: Thu, 13 Mar 2014 09:49:50 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: Node 0 not necessary for powerpc?
Message-ID: <20140313164949.GC22247@linux.vnet.ibm.com>
References: <20140311195632.GA946@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403120839110.6865@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1403120839110.6865@nuc>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12.03.2014 [08:41:40 -0500], Christoph Lameter wrote:
> On Tue, 11 Mar 2014, Nishanth Aravamudan wrote:
> > I have a P7 system that has no node0, but a node0 shows up in numactl
> > --hardware, which has no cpus and no memory (and no PCI devices):
> 
> Well as you see from the code there has been so far the assumption that
> node 0 has memory. I have never run a machine that has no node 0 memory.

Do you mean beyond the initialization? I didn't see anything obvious so
far in the code itself that assumes a given node has memory (in the
sense of the nid). What are your thoughts about how best to support
this?

Thanks,
Nish
