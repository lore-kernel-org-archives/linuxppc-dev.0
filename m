Subject: Re: mpc8xx-2.3.10 configuration questions.
To: dan@netx4.com (Dan Malek)
Date: Fri, 17 Sep 1999 10:48:10 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <37E10DA8.4E819A64@netx4.com> from "Dan Malek" at Sep 16, 99 11:32:56 am
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19990917004810.870CB730@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> The CLLF isn't a really a lite...it's a Classic with less stuff.

Right; I'm with you now.

> I am currently working on this now, and if you actually have a
> CLLF (I don't know how you would) the FEC isn't going to work
> because of the faulty magnetics on the board (not RPCg fault, the
> manufacturer acknowledged an error after we found it).  The new
> CLLFs will be available within a few days.

No, I don't have one yet; I'm just building the kernel in eager anticipation
for when the new CLLF with 860T hits my desk.

> What is fec.c.dist?  It seems like I am always fixing this one.

It's just what I renamed fec.c from the snapshot to before I hacked it.

> I pretty sure I got it right in the 2.3.18 kernel.

I'm using the linux-2.3.18 snapshot kernel from the ftp site, which has it
wrong I'm afraid.

> The CLLF will be built from the Classic configuration, so it
> isn't appropriate to put this here.  There is also more that needs
> to be added for the MII interrupts through a Port C bit.

I've reconfigured/recompiled my kernel for the Classic, but it sounds like it
won't Just Work(tm). I'm happy to alpha test any mods you're working on; once
the board & doco arrive, I can probably do some kernel hacking as well...

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
