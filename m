Return-Path: <Antonio.DiBacco@technolabs.it>
Received: from smtp.technolabs.it (unknown [213.82.155.20])
	by ozlabs.org (Postfix) with ESMTP id B1BB5DDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 18:31:30 +1100 (EST)
MIME-Version: 1.0
Subject: RE: cpm_uart: WARNING: no UART devices found
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 31 Jan 2007 08:31:26 +0100
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8E622D47@aquib01a>
In-Reply-To: <45BF8790.80905@cofsky.com>
From: "DI BACCO ANTONIO - technolabs" <Antonio.DiBacco@technolabs.it>
To: "Evan Cofsky" <evan@cofsky.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thank you, it did work perfectly.=20

-----Original Message-----
From: Evan Cofsky [mailto:evan@cofsky.com]=20
Sent: marted=EC 30 gennaio 2007 19.00
To: DI BACCO ANTONIO - technolabs
Subject: Re: cpm_uart: WARNING: no UART devices found

DI BACCO ANTONIO - technolabs wrote:
> My board has an MPC880 and it is named TL880 with a linux 2.6.19, I
> copied kernel configurations from the very similar board mpc885ads.
> I filled in platform data in file TL880_setup.c but I see that =
function
> TL880_fixup_uart_pdata is never called and, as a consequence, I see =
the
> message cpm_uart: WARNING: no UART devices found. Also I receive
> message: IP-Config: No network devices available.=20

Funny, I just had this problem myself.  After going through and reading
a lot of code, I found out that the macro BOARD_CHIP_NAME must match the
CPU spec in arch/ppc/syslib/mpc8xx_sys.c for the CPU model.  It looks
like trying MPC885 might work.
