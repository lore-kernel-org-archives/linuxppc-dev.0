Subject: Re: questions about porting an 8240 arch to linux
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20021205161437.A16705@crystal.2d3d.co.za>
References: <20021205161437.A16705@crystal.2d3d.co.za>
Content-Type: text/plain
Date: 05 Dec 2002 16:16:42 +0100
Message-Id: <1039101402.651.74.camel@zion>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2002-12-05 at 15:14, Abraham vd Merwe wrote:
>
> Hi!
>
> !!! Here's what I have:
>
> * Board based on Motorola MPC8240 processor (based on 603e core)
> * 32M sdram
> * 250mhz processor
> * board is based on PowerPC microprocessor command hardware reference
> platform (CHRP).

You shouldn't use MPC8xx support, that's for moto embedded CPUS like the
860, 850, 823, ...

You need classic PPC support (that is typically CONFIG_6xx)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
