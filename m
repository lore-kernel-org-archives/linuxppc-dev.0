Return-Path: <aris@cathedrallabs.org>
Date: Fri, 7 Oct 2005 09:31:26 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: apoorv sangal <apoorvsangal@gmail.com>
Message-ID: <20051007123126.GA6879@cathedrallabs.org>
References: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a79669360510062205v629affb9ga687078f018afae@mail.gmail.com>
Cc: apoorv sangal <apoorv_sangal@satyam.com>, vikrant_basotra@satyam.com,
	sibi_mathew@satyam.com, Linuxppc-embedded@ozlabs.org
Subject: Re: Problem Regarding Ping in Linux kernel version 2.4.24
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
>           I have ported Linux kernel version 2.4.24 on MPC8266 based customized
> Board,  having LXT971 ethernet chip.
> The root file system is JFFS2 which i have made using mkfs.jffs2 utility which
> comes along with the ELDK 3.0
> In the kernel code i checked that there is support for the LXT971 chip, but
> even after enabling all the network related funcuntionalities in the linux
> kernel configuration, I am either not able to ping from the board to any
> machine on the network, nor from the any other machine to the board.
> The board is able to ping itself.
> Can some one please throw some light why the board is not able to ping any
> other machine.
try to comment this line in LXT971 section of driver:
	{ mk_mii_write(MII_REG_CR, 0x1200), NULL }, /* autonegotiate */
and check if it works

-- 
Aristeu
