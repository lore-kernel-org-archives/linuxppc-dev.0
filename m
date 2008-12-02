Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr6.xs4all.nl (smtp-vbr6.xs4all.nl [194.109.24.26])
	by ozlabs.org (Postfix) with ESMTP id BA904DDDDF
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 19:55:33 +1100 (EST)
Message-ID: <4934F7FC.2030105@aimvalley.nl>
Date: Tue, 02 Dec 2008 09:55:24 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
Subject: NAND only (no NOR)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Nowadays, do many (PowerPC) embedded devices already risk omitting
NOR flash and use a NAND device solely for booting and storing images ?

I'm talking about systems with 10 years life-cycle (so no
MP3-players nor medical systems but somewhere in between).

We have a MPC8313E-RDB and I know booting from NAND is
possible. U-boot seems to support it well, I assume it can read
the kernel, ramdisk and dtb from NAND in memory and bootm this.

However, having no NOR flash means:
  - NAND should be programmable via JTAG (BDI3000 doesn't support
    this, Lauterbach/trace32 does)
  - Critical software images (u-boot, kernel, dtb) stored on
    NAND, while there's no NAND 'scrubbing', etc..

Thoughts/comments are welcome.
