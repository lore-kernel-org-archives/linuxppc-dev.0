Message-ID: <390F51FC.EC11B8B9@embeddededge.com>
Date: Tue, 02 May 2000 18:09:00 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Interference between SCC serial and ethernet
References: <BE1C564723B3D21191FD0000F840E39801D814EC@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
