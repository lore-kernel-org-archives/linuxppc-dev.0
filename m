Date: Sat, 5 Aug 2000 23:05:14 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: David Edelsohn <dje@watson.ibm.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question 
In-Reply-To: <200008060334.XAA29546@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000805224207.649J-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 5 Aug 2000, David Edelsohn wrote:

> 	I do not know SVR4 that well to know what else might end up in
> rodata other than symbols.  Switch jump tables are the only thing that
> comes to mind.

Good!  That's one less thing to worry about.

> 	Even if the default is to do nothing, one always should provide a
> default action or just break so that the density / coverage of the switch
> statement cases is apparent.

I don't know what the density is, but, if having a default action for
nothing is always prefered, I'll fix it (or rather I'll ask Ben to fix
it.)  Is it in gcc documentation or C standard somewhere?


Thanks,

Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
