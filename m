Message-ID: <406AFFE5.1010003@embeddededge.com>
Date: Wed, 31 Mar 2004 12:29:09 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: John Whitney <johnw@sands-edge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed changes to io.h
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331100159.A17284@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

 > ..... Yes, it's ugly, but hardware folks keep
> configuring devices for a 64-bit bus width.

We have to ensure we don't try to execute these functions on
processors that don't have FPUs.  I think all processors with
64-bit data bus have FPUs, so that may reduce the problem
just by being lucky.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
