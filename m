Return-Path: <ami@waves.com>
Received: from dcmail1.waves.com (dcmail1.waves.com [12.34.136.6])
	by ozlabs.org (Postfix) with SMTP id AD81FDDD09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 18:21:03 +1100 (EST)
From: "Ami Levi Waves" <ami@waves.com>
To: "'Leonid'" <Leonid@a-k-a.net>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: gdb - dgbserver problem
Date: Tue, 20 Feb 2007 08:20:06 +0100
Message-ID: <001401c754bf$a58a4ee0$0600000a@waves.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <406A31B117F2734987636D6CCC93EE3CF9DD6E@ehost011-3.exch011.intermedia.net>
Reply-To: ami@waves.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

You're the second person that tells me there might be a problem with
gdb-gdbserver in Fedora core (I'm using Fedora core 4).
I don't mind giving it a shot. I'll try to upgrade today to Fedora core =
5.

Thanks.
Ami

> -----Original Message-----
> From: Leonid [mailto:Leonid@a-k-a.net]
> Sent: Monday, February 19, 2007 5:54 PM
> To: ami@waves.com; linuxppc-embedded@ozlabs.org
> Subject: RE: gdb - dgbserver problem
>=20
> Which version of Fedora Core are u using? Because I experience similar
> problem (with different board though) and I have Fedora Core 4 while I
> know lady with precisely same setup and Fedora Core 5 and everything =
is
> working fine for her... so how stupid it may seem I started suspect =
FC4...
>=20
> Leonid.
>=20
> ________________________________________
> From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
> Of Ami Levi Waves
> Sent: Monday, February 19, 2007 8:41 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: gdb - dgbserver problem
>=20
>=20
> Hi there,
> I'm having a problem when using gdb to debug an application via the
> gdbserver. It seems the gdbserver crashes when I issue "continue" =
command
> (the target just hangs, no response, no messages on the Linux =
console).
> This is what I'm getting on the gdb side (I'm using verbose and debug
> modes):
> (gdb) continue
> Continuing.
> Sending packet: $Z0,100004dc,4#02...Ack
> Packet received:
> Packet Z0 (software-breakpoint) is NOT supported
> Sending packet: $m100004dc,4#b9...Ack
> Packet received: 3d201000
> Sending packet: $X100004dc,0:#da...Ack
> Packet received:
> binary downloading NOT suppported by target
> Sending packet: $M100004dc,4:7d821008#a1...Ack
> Timed out.
> Timed out.
> Timed out.
> Ignoring packet error, continuing...
> Sending packet: $m3000c380,4#8e...Sending packet:
> $m3000c380,4#8e...Sending packet: $m3000c380,4#8e...Sending packet:
> $m3000c380,4#8e...Timed out.
> Timed out.
> Timed out.
> Ignoring packet error, continuing...
> Reply contains invalid hex digit 116
>=20
> Here are a few words about my setup:
> I'm using an Arabella 2.6.12 custom kernel that contains USB support.
> Everything is working fine (Except for this problem).
> I'm using the new DENX 4.1 toolchain to compile both my kernel &
> application. I'm using Fedora desktop to run the gdb and the gdbserver =
is
> on my custom MPC880 board.
> I'm using IP to connect the gdb to gdbserver. I'm following the exact
> guidelines described on DENX web site.
> In order to simplify the problem I'm using a simple "hello world" =
program.
> Any ideas?
> Thanks.
> Ami Levi
