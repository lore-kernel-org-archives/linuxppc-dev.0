Date: Tue, 21 May 2002 08:42:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem setting breakpoints with BDI2000
Message-ID: <20020521154202.GC1209@opus.bloom.county>
References: <B164B53F5BD6D511888D009027732E1A4D11CC@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B164B53F5BD6D511888D009027732E1A4D11CC@ntserver.act.domain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 21, 2002 at 12:38:01PM +1000, Rudolf Ladyzhenskii wrote:
>
> Hi, all
>
> I have BDI2000 with software version v1.11
> I have problems setting a breakpoint. I am trying to set a breakpoint in the
> start_kernel() function to debug misbehaving kernel.
> So, at command line I type:
> bi 0xXXXXXXXX, where 0xXXXXXXXX is address of start_kernel out of map file.
> BDI does not stop there, it passes this breakpoint. IO tried it with HARD
> and SOFT breakpoints.

What order did you do it in?  That's important.  You need to 'halt',
'load', 'bi 0xabcdef12', 'go'

If you use hard breakpoints, make sure to do a 'ci' and then 'break
soft' either just before attaching with GDB or after attaching but
before you do anything else.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
