Message-Id: <200006281530.RAA30903@denx.local.net>
To: Pei-Jie Hong <Pei-Jie.Hong@cern.ch>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A question about head.S 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Apr 2000 16:29:46 +0200."
             <3909A05A.E1901D52@cern.ch>
Date: Wed, 28 Jun 2000 17:30:03 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3909A05A.E1901D52@cern.ch> you wrote:
>
> In arch/ppc/kernel/head.S, there are lines looks like
> bne 4f or b 5f, I know they are branch instructions, but what
> about 4f or 5f. Are they the relative length? and what is the unit,
> I mean if 4f is a number , is it number of instructions or number
> of bytes or words?

You will also see labels "4:" and "5:" etc. in the text.  "4f"  means
"label  4  searching  forward",  while  "5b"  means "label 5 seaching
backwards".

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
