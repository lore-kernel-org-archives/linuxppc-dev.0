Message-ID: <397CBC73.4DB0233C@cyclades.com>
Date: Mon, 24 Jul 2000 15:00:19 -0700
From: "Edson Ap. Seabra" <seabra@cyclades.com>
MIME-Version: 1.0
To: Linux List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ramdisk using libc5
References: <A109131318C4D1119AC20060088DECE30B9832@amwmail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thank You, Lucinda.

This helps a lot. The libc now has 1.03 Mb ... I guess libc still have a lot of
code that I don't need.  I have to find a easy way to strip them.

Edson.


Lucinda Schafer wrote:

> Try stripping all the debug info out--libc-2.1.2.so will be about 370k.
>
> Lucinda
>
> -----Original Message-----
> From: Edson Ap. Seabra [mailto:seabra@cyclades.com]
> Sent: Monday, July 24, 2000 2:29 PM
> To: Linux List
> Subject: Ramdisk using libc5
>
>         I want to make a ramdisk image for a PPC board that provides
> basic network services
> such as ping, telnet, traceroute and ftp. I would like the final memory
> image size less than 2 Mb. Only libc-2.1.2.so has 4 Mb.
>
> Has  somebody  done this using libc5 ?
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
