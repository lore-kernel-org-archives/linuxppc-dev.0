Message-ID: <22F662CDC53ED411B65700805F31DE1C1359D5@exccop-01.dmo.cpqcorp.net>
From: "Mathiasen, Torben" <Torben.Mathiasen@compaq.com>
To: "'Ron Bianco'" <ronb@junction.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: eepro100 on IBM Walnut board,
Date: Fri, 6 Apr 2001 11:16:04 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks a lot. I'll take a look at some of the older versions.

Regards,
Torben

-----Original Message-----
From: Ron Bianco [mailto:ronb@junction.net]
Sent: 6. april 2001 00:48
To: Torben Mathiasen
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: eepro100 on IBM Walnut board,



Didn't have endian problems in the version we're using on our PPC 8240
board.
The version string says:  eepro100.c:v1.09j 7/27/99 Donald Becker.......etc.
I had problems with newer versions, I think endian issues were one of the
them.

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
> } Has anyone tried using an Intel i82559 NIC as a second adapter with an
IBM Walnut board? I'm using the
> eepro100 driver
> } with the montavista distribution (tried 2.4.0-test2 and 2.4.2) and the
driver just keeps printing:
> wait_for_cmd_timeout.
> } The NIC won't send any frames, and no interrupts are generated.
> }
> } The docs claim that the eepro100 driver should work.
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
