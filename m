Date: Wed, 26 May 1999 08:47:41 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ioctl 0x7667 in Xpmac
In-Reply-To: <Pine.LNX.4.10.9905261056360.7373-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.SUN.4.02.9905260845560.17429-100000@sea.ntplx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 26 May 1999, Geert Uytterhoeven wrote:

> Can the people responsible for Xpmac please change the error message
> 
> | Fatal server error
> | ioctl 0x7667 failed: invalid argument.
> 
> into
> 
> | Fatal server error
> | ioctl 0x7667 failed: invalid argument (do you have a PowerMac?).
> 
> or something like that.
> 
> Many people install LinuxPPC on APUS (the second most popular Linux/PPC
> platform these days), and Xpmac is obviously not meant for non-PowerMacs.

It's easy enough to do, but doesn't APUS have a framebuffer? (Currently
if you don't have a readable /dev/fb0, it assumes MkL and uses Xpmac.  A
more elegant fix would be to check machine type and use that to install
Xbh on PReP and ??? on APUS)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
