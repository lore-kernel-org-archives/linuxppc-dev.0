Message-ID: <BE1C564723B3D21191FD0000F840E39801D815F8@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'Dan Malek'" <dan@netx4.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial Port Baud Rate
Date: Tue, 8 Aug 2000 17:37:08 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Baud rates 300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200 worked
for me, with simple tests.  I have used 9600, 57600, and 115200 far more
than the others.  I did not test any other rates.

The lower Baud rates lose characters when the device is closed before it has
been emptied, but that's a known condition which is usually not a problem
for embedded work.
-- Dave Brown

> -----Original Message-----
> From: Dan Malek [mailto:dan@netx4.com]
>
> "Brown, David (dbrown03)" wrote:
>
> > ....  The modified version runs very well at 115200 Baud,
> > with no framing errors.
>
> Thanks.  What about other baud rates?
>
> > .....  I also included a few lines which should in theory
> > allow very low baud rates, although I have had no reason to
> test this.
>
> But.....I thought you provided this to me before :-)?  I already added
> that to source updates.
>
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
