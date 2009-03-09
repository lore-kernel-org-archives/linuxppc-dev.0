Return-Path: <skrishnakar@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 88E4FDDFA1
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 23:52:06 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1490574rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 05:52:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6213bc560903070759x87658adrb6a9acaa7d4e2855@mail.gmail.com>
References: <6213bc560903070759x87658adrb6a9acaa7d4e2855@mail.gmail.com>
Date: Mon, 9 Mar 2009 18:22:04 +0530
Message-ID: <6213bc560903090552r3f157fe1oe7e7d1930684693a@mail.gmail.com>
Subject: KGDB over serial on xilinx virtex-5 (ppc440)
From: srikanth krishnakar <skrishnakar@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=00504502ccc3fe9c090464af195b
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--00504502ccc3fe9c090464af195b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Has anybody  tested KGDBOC in linux-2.6.28 for Xilinx Virtex-5 PowerPC
target boards..

I just see that KGDB waits for remote connection from GDB host, but
unfortunately


Command line arguments were :

console=ttyS0 ip=bootp root=/dev/nfs rw kgdboc=ttyS0 kgdbwait

The test is been done on xilinx virtex-5 ppc440 target

Target side:

----------------
Serial: 8250/16550 driver4 ports, IRQ sharing disabled
83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq = 16) is a 16550A
console [ttyS0] enabled
kgdb: Registered I/O driver kgdboc.
kgdb: Waiting for connection from remote gdb...

------------------

Host side
------------------
(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
Sending packet: $qSupported#37...Sending packet: $qSupported#37...Sending
packet: $qSupported#37...Sending packet: $qSupported#37...Timed out.
Timed out.
Timed out
.....
.....

------------------

Is anything else need to be implemented for ppc44x for KGDB to work ?




-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--00504502ccc3fe9c090464af195b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">Hi all,<br><br>Has anybody=A0 tested KGDBOC in l=
inux-2.6.28 for Xilinx Virtex-5 PowerPC target boards.. <br><br>I just see =
that KGDB waits for remote connection from GDB host, but unfortunately<br><=
br>
<br>Command line arguments were :<br>
<br>console=3DttyS0 ip=3Dbootp root=3D/dev/nfs rw kgdboc=3DttyS0 kgdbwait<b=
r><br>The test is been done on xilinx virtex-5 ppc440 target<br><br>Target =
side:<br><br>----------------<br>Serial: 8250/16550 driver4 ports, IRQ shar=
ing disabled<br>

83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq =3D 16) is a 16550A<br>conso=
le [ttyS0] enabled<br>kgdb: Registered I/O driver kgdboc.<br>kgdb: Waiting =
for connection from remote gdb...<br><br>------------------<br><br>Host sid=
e<br>

------------------<br>(gdb) target remote /dev/ttyS0<br>Remote debugging us=
ing /dev/ttyS0<br>Sending packet: $qSupported#37...Sending packet: $qSuppor=
ted#37...Sending packet: $qSupported#37...Sending packet: $qSupported#37...=
Timed out.<br>

Timed out.<br>Timed out<br>.....<br>.....<br><br>------------------<br clea=
r=3D"all"><br>Is anything else need to be implemented for ppc44x for KGDB t=
o work ?<br><font color=3D"#888888"><br></font><br></div><br clear=3D"all">=
<br>
-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards<br>Srik=
anth Krishnakar<br>**********************<br>

--00504502ccc3fe9c090464af195b--
