Message-ID: <366FFC59.32C325A7@airways.com>
Date: Thu, 10 Dec 1998 09:52:41 -0700
From: "D. Lance Robinson" <lancer@airways.com>
Reply-To: lancer@airways.com
MIME-Version: 1.0
To: linux-scsi@vger.rutgers.edu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Diamond Fireport 40 (Sym875)
References: <Pine.LNX.4.03.9811252309520.23541-100000@mercator.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
>...
> I borrowed a FirePort 40 from a friend for testing.
> 
...
> The Viking was the last drive on the chain. I tried playing with the
> termination jumper (read: what I thought was the termination jumper, left my
> specs somewhere else :-(, but to no avail. I connected a borrowed CD-Writer
> (PLEXTOR CD-R PX-R412C Rev 1.04) with correct termination to the end of the
> chain to make sure it was no termination problem, but that didn't help.
> 
> Then I removed the Viking from the chain, and everything worked fine. Could it
> be that the cable was too long to use FAST-20 transfers with the Viking? It was
> about 75 cm long.
> 

Geert,

You still probably have a termination problem. You say that the CD-R
works fine. This is a narrow device and only terminates the narrow
signals. The best thing is to use a wide active terminator at the end of
the cable.

<>< Lance.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
