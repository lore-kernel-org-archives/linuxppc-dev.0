Message-ID: <3DF80345.4010808@embeddededge.com>
Date: Wed, 11 Dec 2002 22:32:21 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@directvinternet.com
Cc: Pantelis Antoniou <panto@intracom.gr>,
	joakim.tjernlund@lumentis.se, Tom Rini <trini@kernel.crashing.org>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <NCBBIINEHIPFGJPLBEIFCEPEDPAA.acurtis@directvinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


acurtis@directvinternet.com wrote:

> As for a iova() routine, ioremap() will return a previously configured
> virtual address when asked to map the same physical memory space.

No, it does not.  The ioremap() may do this in some cases on processors
that use BATs for large space mapping, but it usually (always on 8xx)
allocates new virtual space when mapping a physical address.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
