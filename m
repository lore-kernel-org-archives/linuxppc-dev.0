Message-ID: <397D9DDE.E0CA293C@relog.ch>
Date: Tue, 25 Jul 2000 16:02:06 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
To: John Grimes <jpgrimes@johngrimes.dyndns.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86 version 4.01
References: <Pine.LNX.4.21.0007250957380.1469-100000@johngrimes.dyndns.org>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Grimes wrote:
>
> >
> > Does the console work there? If yes, just don't specify any modelines and
> > it will use the console mode.
>
> Nope, console doesn't work for the 2nd monitor so suspect a config issue
> on my side.  Will continue to work on.  Although how would I even get to
> the 2nd monitor on the console, will moving the mouse get me there?  Or is
> it higher console numbers?

First of all, you have to boot the kernel with a second video= paramater for
the internal video (offb may pick it up automatically, don't know).

There are 2 possibilities:

Either also add something like video=map:000111 as a kernel parameter.
Meaning:                                 ^^^
First three virtual consoles on first monitor (fb0)
                                            ^^^
The remaing three on the second one (fb1)

I hope you get the idea...


Or, you can change the mapping between consoles and fbs with a script called
fb2conmap or similar. It's in the Debian fbset package, let's hope it's also
in LinuxPPC...


Michel


--
Pauli's exclusive, Heisenberg's uncertain, and Schroedinger just waves.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
