Message-ID: <38176697.54C0E851@andrew.cmu.edu>
Date: Wed, 27 Oct 1999 16:54:47 -0400
From: Hollis R Blanchard <hollis@andrew.cmu.edu>
MIME-Version: 1.0
To: John Buswell <johnb@one.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac DV and BootX
References: <Pine.LNX.3.96.991027200622.25681C-100000@shell>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


John Buswell wrote:
> 
> hey,
> 
> I have a new iMac DV for a few days now and I've been trying to get it to
> boot Linux. I think I have narrowed the problem down to something wrong
> with BootX. Using BootX 1.2b (in debug mode), I get as far as Exiting
> BootX! message, then it clears the screen, but does not produce the
> booting... message, it just sits there with a nice blank screen while
> still remaining powered up. I had someone try this on an iMac Rev.B and it
> produces lots of debug information after the booting.
> 
> Does anyone have any ideas why? (or better still, someone with a better
> idea of how bootX works that might have some suggestions).
> 
> There is a PICT screen shot of the last screen in BootX before the blank
> screen, available from:
> 
> ftp.one.net/pub/users/johnb/screenshot.gz
> 
> there is also a file there called imacdv.tgz with a complete dump from
> name display registry..
> 
> i'm hoping to get this working soon as i need the imac booting for a
> college project :)

Well, there's some bad news... the new iMac, the iBook, and the Sawtooth
G4's cannot currently run Linux.

A developer has made a lot of progress with an iBook, though. Since
they're based on the same motherboard, that helps with the iMac DV's and
the Sawtooth G4's, but neither of those machines will able to do much
for a while I think. (http://www.linuxppc.org/hardware is pretty clear
about that.)

Of course, if you're curious you might try out the iBook kernel from
http://calvaweb.calvacom.fr/bh40/test.html. It would be interesting to
see how far it gets on an iMac DV.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
