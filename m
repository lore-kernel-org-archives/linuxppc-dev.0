From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910150842.KAA13710@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <3806A9A2.EC5A82D6@mondonet.net> from Mario Scarpa at "Oct 14, 1999 09:12:18 pm"
To: m.scarpa@mondonet.net (Mario Scarpa)
Date: Fri, 15 Oct 1999 10:42:26 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Michael Schmitz wrote:
> >  But if mincom is the only program that is unhappy with the wait, it
> > sure is sufficient to fix minicom (and make the serial driver return
> > -ERESTARTSYS or similar if the wait was interrupted by a signal).
> 
> What about chat ? Fixing it will give a lot of us the
> possibility to use PPP via command line (which I prefer
> btw :)) and, Micheal, chat seems not to work.

What about it? I've never tried it. I can post a diff if you want to try my
kernel hack, but maybe it would make more sense to narrow down why chat
fails. strace -f pppd should also trace chat if pppd is set up to use chat.

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
