Message-ID: <20020219113459.48296.qmail@web9706.mail.yahoo.com>
Date: Tue, 19 Feb 2002 03:34:59 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: Missing "#ifdef" in arch/ppc/boot/simple/mics-embedded.c ?
To: Gerard Basler <gbasler@ee.ethz.ch>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.43.0202191043500.13185-100000@tardis-b01.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  Probably you have choosen at the xconfig to
setup serial console. This is only if you have
a outer chip that supports this function..
(well thats what I understud from the code).
So just dont select this option.

                      D. Meidanis

--- Gerard Basler <gbasler@ee.ethz.ch> wrote:
>
> Hi,
>
> I don´t have any experience with embedded-linux and
> I had a while
> until I managed to compile the Kernel for a PPC405GP
> Walnut
> architecture.
> I always received a compile error in
> arch/ppc/boot/simple/misc-embedded.c
> saying that the function "serial_close" (line 228)
> wasn´t found.
> I looked at line 84:
>
> #ifdef CONFIG_SERIAL_CONSOLE
> com_port = serial_init(0, bp)"
> #endif
>
> and changed
>
> serial_close(com_port);
>
> to
>
> #ifdef CONFIG_SERIAL_CONSOLE
> serial_close(com_port);
> #endif
>
> Now it compiles but I´m not sure if my changes make
> any sense.
> I think that I made some false settings in xconfig
> but I have no idea
> where.
>
> Greetings
>
> Gerard
>
>
>


=====
-------------------------------------------------
  Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
  Greece.
-------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
