Message-ID: <BE1C564723B3D21191FD0000F840E39801D814ED@rfcmx2.rfc.comm.harris.com>
From: "Brown, David (dbrown03)" <DBrown03@harris.com>
To: "'Dan Malek'" <dan@netx4.com>,
        "Brown, David (dbrown03)"
	 <DBrown03@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Interference between SCC serial and ethernet
Date: Wed, 3 May 2000 08:43:26 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okay, since SCC serial and ethernet are known to work simultaneously, I'll
be looking for problems in my board configuration or in the board itself.
We have used the board for a few years, the Ethernet portion is being
exercised for the first time by me.

I'm not expecting help on this .. it's the kind of problem that's hard to
diagnose/debug over a mailing list.  I boot up with root=/dev/ram ip=...,
and Ethernet gets setup and enabled at boot.  Then I use the SCC serial
ports, and they work fine.  Then I ping the board over Ethernet, and the SCC
serial ports don't work anymore.

If I do find software problems in the kernel, I'll certainly report them,
but I'm now expecting to find something wrong with the board or something
wrong with my configuration.
--
Dave Brown <dbrown03@harris.com>

-----Original Message-----
From: Dan Malek [mailto:dan@netx4.com]
Sent: Tuesday, May 02, 2000 6:09 PM
To: Brown, David (dbrown03)
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interference between SCC serial and ethernet


"Brown, David (dbrown03)" wrote:
>
> I have the MontaVista 2.2.13 kernel running on my board.

I need a little help here :-).....I assume it is a 860 class processor,
but what about the board?  There are implementation specific considerations
for the I/O port configurations.  You didn't happen to use some of
the I/O ports for Ethernet control that multiplex to the others?

> The SCC serial ports work fine for me, until I use Ethernet.

How do you boot the system not using Ethernet, then enable it?  Do
you mean running to different kernel configurations?


> ... Has anyone used SCC serial ports and SCC Ethernet simultaneously?

Yes, even multiple Ethernet and multiple SCCs.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
