Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <sbd43a78.005@tms-pty.com>
Date: Mon, 22 Oct 2001 15:25:37 +1100
From: "Jeremy Rosen" <Rosen.Jeremy@tms-pty.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem using FEC on a860T
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello everybody

I am still struggling with my FADS, and the 2.4.4-07.23 kernel from
Denx...

I am trying to have the FEC working, but I hqve problems..

when I compile without "MDIO for PHY configuration"
the kernel prints forever the message  "fec.c[1374] mii_link_interrupt:
unexpected Link interrupt
on the console at boottime.

when I compile with it, the kernel Oopses.
after carefull debugging, I tracked it down to the line 1367 in
arch/ppc/8xx_io/
    mii_do_cmd(dev, fep->phy->ack_int);

it is a kernel access of bad area.

It is possible that I have missed something in the configuration, but I
really can't guess what...

If anybody could help...

Thanks.

Jeremy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
