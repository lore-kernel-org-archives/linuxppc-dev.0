Message-ID: <38EE7EDE.612EB99F@denise.shiny.it>
Date: Fri, 07 Apr 2000 20:35:42 -0400
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: DeRobertis <derobert@erols.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: stty crtscts < /dev/ttyS1
References: <l03130302b4fd80d3a908@[216.164.130.191]> <l03130304b50c8e1b783f@[216.164.131.253]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >> Hardware flow control is broken. The command in the subject line (stty
> >> crtscts < /dev/ttyS1) freezes linux 2.2.14. Any idea why?
> >
> >Try this syntax: "stty -F /dev/ttyS1 crtscts". There's a comment in the
> >info doc for stty that letting the shell open the device may block in
> >certain situations.
>
> Does not help -- still freezes.
>
> By freezes I mean that the kernel dies. It no longer responds to
> keypresses. It no longer runs processes. All that I can do is hit reset.

What is connected to the serial port ?  When I enable RTS/CTS on ttyS1
and there is my Epson 740 attached, the whole system freezed. I don't
know why this happen exactly. It seems that the printer changes continuosly
with very high frequency  the state of CTS, which cause the serial driver
to loop indefinitely. When I detach the cable, Linux awakes. It also happens
with BeOS, but not under MacOS.
RTS/CTS works fine when I connect the serial port to the modem or to
another computer.

Bye.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
