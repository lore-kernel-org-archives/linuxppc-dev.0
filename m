Date: Sat, 27 Jan 2001 16:38:53 -0500
From: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
Message-ID: <20010127163853.C2695@allspice.cs.swarthmore.edu>
References: <20010127022341.24831DBA47@atlas.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010127022341.24831DBA47@atlas.valhalla.net>; from iain@sandoe.co.uk on Sat, Jan 27, 2001 at 02:23:46AM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 27, 2001 at 02:23:46AM +0000, Iain Sandoe <iain@sandoe.co.uk> wrote:
> > You might be able to use xmon as well - I've never tried hard enough to
> > understand xmon.
>
> under 2.4.x xmon isn't too difficult - it's saved my bacon a few times.

I can boot a 2.4.x kernel for this purpose.

> basic instructions:
>
> go to arch/ppc/xmon and edit start.c to enable output to both bootx screen &
> the console (and a serial port as well if you like).  It's kinda grape-shot
> - but if there's any form of oops you will probably see it this way.

I use quik, not bootx (though I could switch for debugging purposes.)
Do I just change the "console = 0" to "console = 1" to get it to work on
my console (I assume that you don't mean the serial console here, but
indeed my screen?)  Or do I need to to something else to the file that
I'm not seeing?

-Daniel

--
Daniel E. Eisenbud
eisenbud@cs.swarthmore.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
