From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910110946.LAA05916@simul.biophys.uni-duesseldorf.de>
Subject: Re: ADB probing
In-Reply-To: <19991008150617.016099@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 8, 1999 03:06:17 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Mon, 11 Oct 1999 11:46:10 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >I can help writing and testing this on a Powerbook, I just don't have a
> >desktop Mac to connect multiple ADB devices to. 
> 
> My idea was to work on this this Sunday, but if you want to write it now,
> feel free to do so ;) I can test it on various configurations at work.

It took a bit longer, but I actually got something to start with. I've only
implemented exclusive access to devices and a simple autopoll data buffering 
so far. I still need to conditionalize the gobs of debug messages but it's
now possible to take over a specific device from user space and get the
autopoll data from it (tested with a hacked version of the trackpad tool that
would take over the trackpad for 10 seconds). 
I haven't implemented poll yet, and there's a few implementation details that 
need discussion. Did you do any work on this yet? I'd send a diff (relative
to 2.2.12) otherwise for you to test. 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
