Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id E696D67B44
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 07:20:59 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Alex Zeffertt'" <ajz@cambridgebroadband.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Tue, 13 Jun 2006 23:20:57 +0200
Message-ID: <001001c68f2f$42f6e730$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <448EEC59.2010201@cambridgebroadband.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 

> -----Original Message-----
> From: 
> linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se@ozlabs.
> org 
> [mailto:linuxppc-embedded-bounces+joakim.tjernlund=lumentis.se
> @ozlabs.org] On Behalf Of Alex Zeffertt
> Sent: den 13 juni 2006 18:48
> To: linuxppc-embedded@ozlabs.org
> Subject: No ttyS device at I/O port 0xfe004500 for console
> 
> Hi list,
> 
> I'm trying to boot a linux-2.6.11 kernel on a MPC83xx based 
> board.  Through some experimentation I have found I need 
> "console=uart,io,0xfe004500"
> in the kernel command line in order to get any output over 
> the serial port.

Alex, can you post your complete u-boot env(printenv). I am trying to do
the same as you but I havn't gotten any output yet. I managed to wipe my
u-boot & u-boot env and the docs arent that great :(

 Jocke
