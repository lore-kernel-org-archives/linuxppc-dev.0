Date: Tue, 19 Feb 2002 11:27:40 +0100 (MET)
From: Gerard Basler <gbasler@ee.ethz.ch>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Missing "#ifdef" in arch/ppc/boot/simple/mics-embedded.c ?
Message-ID: <Pine.GSO.4.43.0202191043500.13185-100000@tardis-b01.ee.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I don´t have any experience with embedded-linux and I had a while
until I managed to compile the Kernel for a PPC405GP Walnut
architecture.
I always received a compile error in
arch/ppc/boot/simple/misc-embedded.c
saying that the function "serial_close" (line 228) wasn´t found.
I looked at line 84:

#ifdef CONFIG_SERIAL_CONSOLE
com_port = serial_init(0, bp)"
#endif

and changed

serial_close(com_port);

to

#ifdef CONFIG_SERIAL_CONSOLE
serial_close(com_port);
#endif

Now it compiles but I´m not sure if my changes make any sense.
I think that I made some false settings in xconfig but I have no idea
where.

Greetings

Gerard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
