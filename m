Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 0B662684E3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Oct 2005 04:27:10 +1000 (EST)
Date: Thu, 13 Oct 2005 11:26:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Ashish Bijlani <ashish.bijlani@gmail.com>
Message-ID: <20051013182654.GA18497@mag.az.mvista.com>
References: <ec55b17e0510130042m6c6c0c43ndf09f40a03f9cf97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec55b17e0510130042m6c6c0c43ndf09f40a03f9cf97@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC7447A based board with MV64462 Marvell Discovery III
	controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 13, 2005 at 01:12:19PM +0530, Ashish Bijlani wrote:
> Hi,
> 
> I'm trying to bring MPC7447A based board with MV64462 Marvell Discovery III
> controller up. Can you guide me to Linux-2.6 sources with support for
> MV64462 Marvell Discovery III controller and MPC7447A PowerPC processor.
> Support for I2c, dual 10/100/1000 ethernet ports, and relevant platform
> should be there. I cannot access the bit keeper repositories so please guide
> me to the linux-2.6 kernel source tree if you can.

Ashish,

Support for both the 7447A and mv64x6x is in the latest 2.6 mainline
kernel source at kernel.org.

If your board is a chrp/openfirmware board, then you probably want to use
the Pegasos code as an example.  If your board has U-boot or some other
non-OF firmware, then use the katana or chestnut as an example (katana
is more up-to-date than the chestnut).  The ev64360 code may help too.
There are i2c and enet drivers (and mpsc and wdt) in that source as well.

Note that I've never had a 64462 to test with.   Since the '2' means it
has less functionality than the '0', you may run into some problems.
If you do, please let me know what they are.

Mark
