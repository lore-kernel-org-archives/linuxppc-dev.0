From: benh@kernel.crashing.org
To: <paulus@samba.org>, Troy Benjegerdes <hozer@drgw.net>
Cc: <linux-galileo@source.mvista.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 merge warning
Date: Tue, 2 Apr 2002 23:15:44 +0100
Message-Id: <20020402221544.21559@mailhost.mipsys.com>
In-Reply-To: <15530.40918.517084.226235@argo.ozlabs.ibm.com>
References: <15530.40918.517084.226235@argo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I'm getting close to a point where I want to start merging appropriate
>> things from the linuxppc_2_4_galileo tree on source.mvista.com into
>> 2_4_devel.
>
>I'll be interested to see it - I'm in code review mode at the moment. :)
>
>> The first thing I'm going to do is a moderately large cleanup to
>> drivers/net/gt64260_eth.c.
>
>Good.  Can you get rid of the config option for the MAC address?
>Please? :)  I suggest that we define a BI_MAC_ADDRESS bi_rec type
>which is used to pass in a default MAC address for the system, and we
>use that (single) MAC address for all the ethernet interfaces on the
>system which don't have any way to find out a MAC address for that
>specific interface.

I'm almost done with the new bi_rec stuffs, I'll push it to _2_5
this week as soon as I've tested a bit.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
