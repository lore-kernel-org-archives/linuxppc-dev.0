Date: Thu, 25 Feb 1999 11:31:53 -0800 (PST)
From: "Robert G. Werner" <rwerner@lx1.microbsys.com>
To: "sean o'malley" <somalley@ed.mde.state.mi.us>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PowerPC Beowulf Who?
In-Reply-To: <v04003a02b2fac8f8e52a@[204.22.210.180]>
Message-ID: <Pine.LNX.3.96.990225111922.10782A-100000@lx1.microbsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm sorry,  but I don't understand what you mean about Firewire begging for
clustering.  It is an interesting technology in concept but it hasn't been
implemented for much of anything but some cameras and maybe a hard drive or
two.  I know we are no where near having firwire working under Linux.  
I think you will find that Firwire doesn't have a Price/performance ratio that
is adnvantageious over 100mb Ethernet and later Gb ethernet.  That technology
has been implemented,  is relatively mature and works under nearly all OSs.
Let's not get confused here,  paralale processing works best when each node can
be given a chunk of the problem and associated data and then left alone.  Every
time the cluster has to hit the network for anything more than a small message,
we lose performance relative to an SMP machine (internal data busses are always
going to be faster than going out to the network).  Huge bandwidth isn't really
the biggest constraint with clusters.  Breaking up the problem correctly is
much more important.

Just because you use Firewire doesn't mean you aren't going to use TCP/IP.
That is up to the drivers and what your basic networking stack can support.  I
may be wrong on this but I haven't heard anything about Firewire requiring a
different protocol.  Seems like it would be a lot of work to make one up too,
especially as we have a very nice TCP/IP stack in Linux.

Robert G. Werner
rwerner@lx1.microbsys.com
Impeach Conggress!!

If the girl you love moves in with another guy once, it's more than enough.
Twice, it's much too much.  Three times, it's the story of your life.

On Thu, 25 Feb 1999, sean o'malley wrote:

[snip]


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
