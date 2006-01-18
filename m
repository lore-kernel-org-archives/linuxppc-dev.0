Return-Path: <dan@embeddededge.com>
In-Reply-To: <20060118012837.70518.qmail@web32113.mail.mud.yahoo.com>
References: <20060118012837.70518.qmail@web32113.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <f1e571d3a8b8813c95659dea615cace9@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Question about SCC Ethernet driver
Date: Tue, 17 Jan 2006 21:04:16 -0500
To: David Tao <david_xtao@yahoo.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 17, 2006, at 8:28 PM, David Tao wrote:

> Present MPC8260 SCC Ethernet driver supports=A0one 10M Ethernet port =
for=20
> SCC1 or SCC2.

Not any more.  Take a look at drivers/net/fs_enet in the 2.6 kernels.
I'm sure Pantelis will have more information when he reads this.

> 1. Is it possible to=A0implement 7 Ethernet ports (3 FCCs and 4 SCCs) =
on=20
> a MPC8270? I didn't see any hardware restriction on this. Performance=20=

> may be an issue?=A0

Depends what you want to do with the data in the CPU core and the
clock speeds you have chosen.  The CPM can handle the data traffic on
the wires if you run it over 133 MHz.

Thanks.

	-- Dan
