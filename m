Message-ID: <39CA1221.340B4C52@isn.net>
Date: Thu, 21 Sep 2000 10:50:25 -0300
From: "Garst R. Reese" <reese@isn.net>
MIME-Version: 1.0
To: linux-irda@pasta.cs.UiT.No
CC: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [Linux-IrDA]IrDA speed w/LinuxPPC: again [long, sorry]
References: <39C9F8A2.9F1707B0@mpifr-bonn.mpg.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Albrecht Dreß wrote:
>
> I still had no success in changing the speed of the IrDA if on my Apple
> PowerBook 1999 with Linux2.2.17pre20-ben3. To understand better what goes on, I
> enabled all debugging in the macserial and irda drivers, adding/expanding some
> more messages to the latter ones.
>
> I first successfully tried to change the speed of the serial device to 115.2
> kBd:
[snip the long story]
>
> Any help or comment on this is really welcome!
>
> Thanks in advance, Albrecht.
>
Part of what you are seeing is the working of the IrDA spec. Everything
starts at 9600baud to negotiate a connection. Part of this negotiation
is the speed it will switch to when a connection is established. This
appears to to be working. It is pointless to preset your tty speed. I
don't know where the cmd garbage is coming from.
Garst

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
