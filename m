From: "Ron Bianco" <ronb@junction.net>
To: "Torben Mathiasen" <torben@kernel.dk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: eepro100 on IBM Walnut board,
Date: Thu, 5 Apr 2001 15:47:40 -0700
Message-ID: <001601c0be22$6b8ecca0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <20010405143318.E1889@ftsoj.fsmlabs.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Didn't have endian problems in the version we're using on our PPC 8240 board.
The version string says:  eepro100.c:v1.09j 7/27/99 Donald Becker.......etc.
I had problems with newer versions, I think endian issues were one of the them.

Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Cort
> Dougan
> Sent: Thursday, April 05, 2001 1:33 PM
> To: Torben Mathiasen
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: eepro100 on IBM Walnut board,
>
>
>
> The latest eepro has serious endian-ness problems.  PPC and MIPS suffer
> this problem.
>
> } Has anyone tried using an Intel i82559 NIC as a second adapter with an IBM Walnut board? I'm using the
> eepro100 driver
> } with the montavista distribution (tried 2.4.0-test2 and 2.4.2) and the driver just keeps printing:
> wait_for_cmd_timeout.
> } The NIC won't send any frames, and no interrupts are generated.
> }
> } The docs claim that the eepro100 driver should work.
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
