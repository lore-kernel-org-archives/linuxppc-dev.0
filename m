Date: Sun, 28 Jan 2001 01:05:06 +0000
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao
	 mode
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
Cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Amit Chaudhary <amitc@brocade.com>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010128010502.63D922EFF3@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Do I just change the "console = 0" to "console = 1" to get it to work on
> my console

yes, assuming that console is is on your screen  ;-)

of course the console redirection of /proc kernel messages mechanisms  have
to be running - i.e. don't expect output when you're in 'single'

- although the info is indeed in the kernel /proc log. and you could tee it
to the screen and a file by hand...

Once klogd is going everything's fine.  (this is why I often enable the
grape-shot approach... )

>(I assume that you don't mean the serial console here, but indeed my screen?)

I'm fairly sure that as far as xmon is concerned - console is console - if
you set your console to a serial port elsewhere - I would expect the xmon
output to come out of that instead.

> Or do I need to to something else to the file that I'm not seeing?

nope, not that I know.

BTW: if you enable serial output in xmon - be aware you have to make sure
the baud rate is correct by hand as well.  By default it is set to 115 kb
(IIRC) correct for talking via modem - but pretty useless for most
"hardware" terminals

I wrote the scc formula down somewhere... (but you can find it in the serial
drivers with a little look).

good luck,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
