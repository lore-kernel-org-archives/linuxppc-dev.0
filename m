Return-Path: <cl@linux.com>
Received: from qmta02.emeryville.ca.mail.comcast.net
 (qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
 by ozlabs.org (Postfix) with ESMTP id 056E42C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 00:41:47 +1100 (EST)
Date: Wed, 12 Mar 2014 08:41:40 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Node 0 not necessary for powerpc?
In-Reply-To: <20140311195632.GA946@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1403120839110.6865@nuc>
References: <20140311195632.GA946@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 11 Mar 2014, Nishanth Aravamudan wrote:
> I have a P7 system that has no node0, but a node0 shows up in numactl
> --hardware, which has no cpus and no memory (and no PCI devices):

Well as you see from the code there has been so far the assumption that
node 0 has memory. I have never run a machine that has no node 0 memory.
