Message-ID: <406B4BC8.4040501@embeddededge.com>
Date: Wed, 31 Mar 2004 17:52:56 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: John Whitney <johnw@sands-edge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <20040331100318.B17284@home.com> <9B139B02-834D-11D8-9FF0-000A95A07384@sands-edge.com> <20040331150741.D17284@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:


> ..... If e500 wanted a version they
> can use the SPE option to add some code.

This isn't an issue (yet) for e500.  The only 64-bit external bus is
for the DDR.  The only functions using the quad word are for MTD flash,
and all flash is on the 32-bit local bus.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
