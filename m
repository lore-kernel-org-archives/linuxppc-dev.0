Message-ID: <010701c0a12c$3c84c120$2501000a@sid>
From: "Sid" <sid@innvo.com>
To: <linuxppc-dev@lists.linuxppc.org>
References: <Pine.SOL.4.10.10102261324080.29120-100000@jennifer.informatik.rwth-aachen.de> <021801c0a016$749636a0$2501000a@sid>
Subject: Re: MBX860 - minicom trouble continues
Date: Wed, 28 Feb 2001 10:14:47 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I managed to construct a temporary power supply and get the board running.
I also got the (till now missing) original documentation for the board from
the
Motorola website. I have found out how essential this was. :)

Now all the correct lights light up and the CPU light keeps blinking. I
assume
this means that the CPU is active. The problem is, instead of getting an
EPPCBug prompt on minicom, I get a series of outputs on the screen which say
"ABCDEFGHz". Nothing else happens.

This happens whether I select the ROM or the FLASH as the source of the
debugger. My board is an MBX860-006C.

Is this normal? Please suggest troubleshooting steps.

Thank you for your time.

regards,
Sid
--
sid@siddhartha.8m.com

"[The knowledge  to reconnect  a brain]  does  not  [exist  yet  in  the
   galaxy.]
  -- Spock, "SPOCK'S BRAIN"

----- Original Message -----
From: "Sid" <sid@innvo.com>
To: "Karl-Heinz Krempels" <charlie@pool.informatik.rwth-aachen.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Sent: Tuesday, February 27, 2001 1:06 AM
Subject: Re: MBX860 - minicom


>
> > Hi,
> >
> > please check your cables. I think its a handshaking problem.
> >
> > \Charlie.
>
> Hi,
>
> I discovered the reason. My 3.3 V input pin was only receiving 1.8V and
all
> the lights were not turning on.
>
> This is because I couldn't find a standard power supply for this board and
I
> had to make a make-shift one and apparently the load on the 3.3V pin is so
> high that my power supply can't handle it.
>
> Could anyone using this board tell me what kind of power supply they are
> using on this board? Maybe even the expected load resistance at normal
> operation, so that I have a rough gauge of the Input current required to
> drive it at 3.3V.
>
> Do power pcs have a different lkind of power supply than the i386
machines?
> As in the Voltage/Current specs.
>
> Thank you once again.
>
> regards,
> Sid
> --
> sid@siddhartha.8m.com
>
> Kirk: "Oh, by the way, thank you for this."
> Spock: "I know of your fondness for antiques."
> Kirk: "'It was the best of times, it was the worst of times.'  Message,
> Spock?"
> Spock: "None that I'm conscious of.  Except of course, happy birthday.
>   Surely, the best of times."
> --"STII:TWOK", Stardate 8130.3
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
