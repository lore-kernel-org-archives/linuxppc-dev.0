Return-Path: <cl@linux.com>
Received: from qmta11.emeryville.ca.mail.comcast.net
 (qmta11.emeryville.ca.mail.comcast.net [IPv6:2001:558:fe2d:44:76:96:27:211])
 by ozlabs.org (Postfix) with ESMTP id 21EA81400C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 04:02:06 +1100 (EST)
Date: Tue, 25 Mar 2014 11:53:48 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Bug in reclaim logic with exhausted nodes?
In-Reply-To: <20140325162303.GA29977@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1403251152250.16870@nuc>
References: <20140311210614.GB946@linux.vnet.ibm.com>
 <20140313170127.GE22247@linux.vnet.ibm.com>
 <20140324230550.GB18778@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1403251116490.16557@nuc>
 <20140325162303.GA29977@linux.vnet.ibm.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-mm@kvack.org, mgorman@suse.de, linuxppc-dev@lists.ozlabs.org,
 anton@samba.org, rientjes@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 25 Mar 2014, Nishanth Aravamudan wrote:

> On 25.03.2014 [11:17:57 -0500], Christoph Lameter wrote:
> > On Mon, 24 Mar 2014, Nishanth Aravamudan wrote:
> >
> > > Anyone have any ideas here?
> >
> > Dont do that? Check on boot to not allow exhausting a node with huge
> > pages?
>
> Gigantic hugepages are allocated by the hypervisor (not the Linux VM),

Ok so the kernel starts booting up and then suddenly the hypervisor takes
the 2 16G pages before even the slab allocator is working?

Not sure if I understand that correctly.
