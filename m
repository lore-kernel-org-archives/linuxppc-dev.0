From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15530.40918.517084.226235@argo.ozlabs.ibm.com>
Date: Wed, 3 Apr 2002 16:23:18 +1000 (EST)
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: GT64260 merge warning
In-Reply-To: <20020402230411.G6003@altus.drgw.net>
References: <20020402230411.G6003@altus.drgw.net>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes writes:

> I'm getting close to a point where I want to start merging appropriate
> things from the linuxppc_2_4_galileo tree on source.mvista.com into
> 2_4_devel.

I'll be interested to see it - I'm in code review mode at the moment. :)

> The first thing I'm going to do is a moderately large cleanup to
> drivers/net/gt64260_eth.c.

Good.  Can you get rid of the config option for the MAC address?
Please? :)  I suggest that we define a BI_MAC_ADDRESS bi_rec type
which is used to pass in a default MAC address for the system, and we
use that (single) MAC address for all the ethernet interfaces on the
system which don't have any way to find out a MAC address for that
specific interface.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
