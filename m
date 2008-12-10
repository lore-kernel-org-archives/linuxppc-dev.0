Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D1262DDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 15:01:39 +1100 (EST)
Date: Tue, 9 Dec 2008 23:01:35 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Mitch Bradley" <wmb@firmworks.com>
Subject: Re: [PATCH] ndfc driver
Message-ID: <20081209230135.35e1b9d1@lappy.seanm.ca>
In-Reply-To: <493E24D8.6040406@firmworks.com>
References: <20081203222832.3fc77d28@lappy.seanm.ca>
	<20081204090107.20269571@zod.rchland.ibm.com>
	<20081208193446.37e27e26@lappy.seanm.ca>
	<20081209021115.GA13948@oksana.dev.rtsoft.ru>
	<20081208214512.461276d2@lappy.seanm.ca>
	<20081208223227.19a702a9@zod.rchland.ibm.com>
	<20081208235437.08323e3a@lappy.seanm.ca>
	<493E24D8.6040406@firmworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 08 Dec 2008 21:57:12 -1000
"Mitch Bradley" <wmb@firmworks.com> wrote:

> One address/size cell isn't enough for the next generation of NAND
> FLASH chips.
> 

I am no dts expert, but I thought I could put:

	nand {
		#address-cells = <1>;
		#size-cells = <1>;

in my dts and you could put:

	nand {
		#address-cells = <2>;
		#size-cells = <2>;

and, assuming we specified the reg entry right, everything would just
work. Is that assumption wrong?

And if the assumption is true, should I make a note in the doc that you
can make the address and size bigger?

Cheers,
   Sean
