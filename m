From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15531.32246.283097.469203@argo.ozlabs.ibm.com>
Date: Thu, 4 Apr 2002 08:11:02 +1000 (EST)
To: benh@kernel.crashing.org
Cc: Troy Benjegerdes <hozer@drgw.net>,
	<linux-galileo@source.mvista.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: GT64260 merge warning
In-Reply-To: <20020402221544.21559@mailhost.mipsys.com>
References: <15530.40918.517084.226235@argo.ozlabs.ibm.com>
	<20020402221544.21559@mailhost.mipsys.com>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


benh@kernel.crashing.org writes:

> I'm almost done with the new bi_rec stuffs, I'll push it to _2_5
> this week as soon as I've tested a bit.

Interesting...  I hope we're not going to end up with a lot of extra
complexity for not very much gain, though.  If we are going to have a
more complex bi_rec setup, let's make sure that it is capable of
expressing a complete device tree.  If not then I would prefer to see
a minimal amount of extra complexity.

In other words I think there are 2 tenable positions: the minimal one,
which just adds a BI_MAC_ADDR and maybe a BI_GT64260_ADDR tag to the
existing list of tags (and makes no change to the bi_rec structure),
and a full-featured one which allows for a tree of device records with
each device having a list of properties, each with a string name and
arbitrary binary data.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
