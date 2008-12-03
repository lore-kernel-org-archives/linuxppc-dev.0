Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 32D8CDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 13:50:36 +1100 (EST)
Date: Tue, 2 Dec 2008 21:50:33 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Norbert van Bolhuis" <nvbolhuis@aimvalley.nl>
Subject: Re: NAND only (no NOR)
Message-ID: <20081202215033.501f3403@lappy.seanm.ca>
In-Reply-To: <4934F7FC.2030105@aimvalley.nl>
References: <4934F7FC.2030105@aimvalley.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, u-boot@lists.denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 02 Dec 2008 09:55:24 +0100
"Norbert van Bolhuis" <nvbolhuis@aimvalley.nl> wrote:

> 
> Nowadays, do many (PowerPC) embedded devices already risk omitting
> NOR flash and use a NAND device solely for booting and storing
> images ?
> 
> I'm talking about systems with 10 years life-cycle (so no
> MP3-players nor medical systems but somewhere in between).
> 
> We have a MPC8313E-RDB and I know booting from NAND is
> possible. U-boot seems to support it well, I assume it can read
> the kernel, ramdisk and dtb from NAND in memory and bootm this.

We use a 256M NAND on the PIKA Warp appliance and where unable to boot
u-boot from the NAND. It worked on a smaller 64M NAND.

So we put our FPGA and u-boot in a small NOR. The kernel, rootfs and
other files are on the NAND.

Cheers,
   Sean
