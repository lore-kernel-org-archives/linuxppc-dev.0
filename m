Date: Fri, 8 Oct 1999 16:07:41 -0700 (PDT)
From: Brad Midgley <brad@turbolinux.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: "David A. Gatwood" <dgatwood@mvista.com>, bh40@calva.net,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB probing
In-Reply-To: <199910080944.LAA03438@simul.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.10.9910081604290.30742-100000@web1.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> I really don't like polling, but there probably isn't anything else to
> 
> The only other thing I can imagine is to keep the default IDs unoccupied,
> and watch for packets from these IDs. 

I like this approach because it effectively disables the hard reset that a
keyboard on the default id can perform and would be able to move keyboards
off the default as soon as it noticed them.

How does all this discussion fit in with the work being done on the input
system which will allow multiple independent keyboards, etc.?

Brad
brad@pht.com | http://www.pht.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
