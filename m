In-Reply-To: <20040331230620.ACC3BC10A4@atlas.denx.de>
References: <20040331230620.ACC3BC10A4@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <812363C6-8371-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <jwhitney-linuxppc@sands-edge.com>
Subject: Re: Proposed Kconfig update patch for help text 
Date: Wed, 31 Mar 2004 19:14:12 -0500
To: Wolfgang Denk <wd@denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


We can put in "8xx", but I didn't think that the listed processors was
supposed to be an exhaustive list (just some examples).   Shall we just
prune them down to "8xx", "4xx", etc.?

John

On Mar 31, 2004, at 6:06 PM, Wolfgang Denk wrote:

> In message <B755A2F6-8364-11D8-9FF0-000A95A07384@sands-edge.com> you wrote:
>>
>> A couple of trivial changes for the processor choice help text to
>> make it a bit clearer.
> ...
>>        types (601, 603, 604, 740, 750, 7400), the Motorola embedded
>> -     versions (821, 823, 850, 855, 860, 8260), the IBM embedded
>> versions
>> +     versions (821, 823, 850, 855, 860, 82xx), the IBM embedded
>
> How about types like 857, 862, the 866 family, the 885 family, ... ?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
