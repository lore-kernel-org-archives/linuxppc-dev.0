Message-ID: <3F427D6C.7@ecubics.com>
Date: Tue, 19 Aug 2003 13:41:32 -0600
From: emanuel stiebler <emu@ecubics.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.1.0, kernel 2.4.21, MPC8245, ntpd
References: <20030819190503.EA35FC59E4@atlas.denx.de>
In-Reply-To: <20030819190503.EA35FC59E4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> Dear Emanuel,
>
> in message <3F426F17.3090206@ecubics.com> you wrote:
>
>>I get a "Segmentation fault (core dumped)" on my system using ntpd.
>
>
> This is caused by some (I2C based RTC's in "11 minute mode".

Sorry Wolfgang,

this one is a STMicro M48T86 (ds12887 compatible), and is sitting on the
local bus ...

>>I checked the archives, and there is one messeage about something like
>>this on a 405.
>>
>>Is anybody working on this ? Did I missed some patches ?
>
>
> We fixed this by making this mode configurable  (and  disable  it  by
> default) in our version of the linuxppc_2_4_devel tree; the patch was
> added on May 29, so just "cvs update" your source tree.

I have to check again, but the kernel was made on july 15. And usually I
update my sources before build. But I check again ...

Thanks,
emanuel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
