Message-ID: <406CB2AC.3020001@246tNt.com>
Date: Fri, 02 Apr 2004 02:24:12 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc5xxx support (Was: Re: Proposed Kconfig update patch for help
 text)
References: <20040401170515.E5C8EC10A4@atlas.denx.de>
In-Reply-To: <20040401170515.E5C8EC10A4@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wolfgang Denk wrote:

>>- Ignore the Motorola code, or since it's GPL (must be to be in the
>>  kernel, so I'm just making the assumption here...) use it as a guide
>>  for how things work to implement a clean Linux implementation of
>>  the code. I know there's someone working on this (who pops up on
>>  #mklinux on freenode from time to time) but I don't know how far
>>  they've gotten.
>
>Ummm... Why is there no discussion about this on any mailing list? And
>don't you think that that at least Motorola should be included in any
>such attempts? [AFAICT they are not, at least not until today.] Also,
>isn't this kind of wasted effort as the target is still moving?

Well, huh, I talked about it on the embedded ml :

http://lists.linuxppc.org/linuxppc-embedded/200403/msg00082.html

along with some 'strange stuff' in the 2.4 port memory map

http://lists.linuxppc.org/linuxppc-embedded/200403/msg00095.html

Yeah sure, having Motorola involved would certainly help, but I don't
have any official contact with them and my Motorola semiconductor
distributor and I are not in best terms recently so I just hoped that
some one concerned at motorola would be reading the list ...

About the bestcomm code more precisly :
A lot of people told me that the code had some issues. So for the 2.6 I
just though that I would rewrite a code that would only fits the linux
needs. Of course I won't just ignore the motorola code, for me rewriting
is looking at the current implementation is just a way to a better
understanding on how it works. If at the end, the motorola code is
cleaner/more generic and works better, then just use it, but as I
understand it it's not the case right now. If I'm not right, then,
please correct me.

Sylvain Munaut

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
