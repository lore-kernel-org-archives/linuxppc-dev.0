Message-ID: <3CED2ECD.4090405@embeddededge.com>
Date: Thu, 23 May 2002 14:02:53 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Cc: acurtis@onz.com, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: eieio rule-of-thumb?
References: <3CED26BB.2080700@embeddededge.com> <20020523184426.19045@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org wrote:


> Regarding eieio on uncached, Paul or Anton can tell you more about it,
> I think there is still a case where guarded doesn't prevent a load
> from moving accross a store.

Oh right....You get guarded to prevent out of order loads, and I just
get lucky that the uncached store doesn't cross the load.

> Regarding the bridge,...

OK.  I thought that was a PCI master, memory controller thing, not
something that would happen from a CPU programmed I/O.


> I think it is on desktop CPUs, but again, here, Paul and Anton have more
> knowledge than I do.

Right.  I know I found a couple of things we had to update for the 74xx
processors.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
