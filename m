Message-ID: <406B5C7F.6050408@embeddededge.com>
Date: Wed, 31 Mar 2004 19:04:15 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: John Whitney <jwhitney-linuxppc@sands-edge.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed Kconfig update patch for help text
References: <20040331230620.ACC3BC10A4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <B755A2F6-8364-11D8-9FF0-000A95A07384@sands-edge.com> you wrote:
>
>>       types (601, 603, 604, 740, 750, 7400), the Motorola embedded
>>-     versions (821, 823, 850, 855, 860, 8260), the IBM embedded
>>versions
>>+     versions (821, 823, 850, 855, 860, 82xx), the IBM embedded
>
>
> How about types like 857, 862, the 866 family, the 885 family, ... ?

Well, the 821 should be canned, but I think all we differentiate
is 823/850 and "others", don't we?  The rest of the configuration
is determined by your I/O choices, which I personally like so we
don't have config files littered with all of the different CPM and
peripheral variations.  In fact, I think we currently just ask for
alternate SMC1 pin mapping, so we don't even need to specifically
know 823/850.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
