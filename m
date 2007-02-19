Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id 5A0F8DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Feb 2007 03:54:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: gdb - dgbserver problem
Date: Mon, 19 Feb 2007 08:54:08 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3CF9DD6E@ehost011-3.exch011.intermedia.net>
In-Reply-To: <000801c75444$c5e24c40$0600000a@waves.com>
References: <000801c75444$c5e24c40$0600000a@waves.com>
From: "Leonid" <Leonid@a-k-a.net>
To: <ami@waves.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Which version of Fedora Core are u using? Because I experience similar =
problem (with different board though) and I have Fedora Core 4 while I =
know lady with precisely same setup and Fedora Core 5 and everything is =
working fine for her... so how stupid it may seem I started suspect =
FC4...

Leonid.

________________________________________
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Ami Levi Waves
Sent: Monday, February 19, 2007 8:41 AM
To: linuxppc-embedded@ozlabs.org
Subject: gdb - dgbserver problem

=A0
Hi there,
I'm having a problem when using gdb to debug an application via the =
gdbserver. It seems the gdbserver crashes when I issue "continue" =
command (the target just hangs, no response, no messages on the Linux =
console).
This is what I'm getting on the gdb side (I'm using verbose and debug =
modes):
(gdb) continue
Continuing.
Sending packet: $Z0,100004dc,4#02...Ack
Packet received:
Packet Z0 (software-breakpoint) is NOT supported
Sending packet: $m100004dc,4#b9...Ack
Packet received: 3d201000
Sending packet: $X100004dc,0:#da...Ack
Packet received:
binary downloading NOT suppported by target
Sending packet: $M100004dc,4:7d821008#a1...Ack
Timed out.
Timed out.
Timed out.
Ignoring packet error, continuing...
Sending packet: $m3000c380,4#8e...Sending packet: =
$m3000c380,4#8e...Sending packet: $m3000c380,4#8e...Sending packet: =
$m3000c380,4#8e...Timed out.
Timed out.
Timed out.
Ignoring packet error, continuing...
Reply contains invalid hex digit 116
=A0
Here are a few words about my setup:
I'm using an Arabella 2.6.12 custom kernel that contains USB support. =
Everything is working fine (Except for this problem).
I'm using the new DENX 4.1 toolchain to compile both my kernel & =
application. I'm using Fedora desktop to run the gdb and the gdbserver =
is on my custom MPC880 board.=20
I'm using IP to connect the gdb to gdbserver. I'm following the exact =
guidelines described on DENX web site.=20
In order to simplify the problem I'm using a simple "hello world" =
program.=20
Any ideas?
Thanks.
Ami Levi
