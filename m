Return-Path: <sven.luther@wanadoo.fr>
Date: Thu, 26 Oct 2006 01:13:25 +0200
From: Sven Luther <sven@genesi-usa.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
Message-ID: <20061025231324.GA16152@powerlinux.fr>
References: <453FB582.20802@bplan-gmbh.de>
	<528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
	<1161817576.22582.142.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161817576.22582.142.camel@localhost.localdomain>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, sven@genesi-usa.com, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2006 at 09:06:16AM +1000, Benjamin Herrenschmidt wrote:
> > > * serial stuff / IBP Freq. As this frequency is MPC52xx specific. I
> > > think it would make sense to add a new func mpc52xx_getipbfreq(void).
> > > The way it would be implemented may depend of the architecture. Our
> > > firmware contains an 'ipb-freq' property in '/builtin/'.
> 
> BTW. I forgot to comment on the above in my previous mail... As I said,
> there should be no such thing. Instead, the IPB freq should be in the
> device-tree.

Euh, how is this different from having our "firmware contains an 'ipb-freq'
property in '/builtin/'". There is no an ipb-freq property in the device tree,
so you need a function to be able to get it from the the device tree, which i
believe what is proposed here.

Friendly,

Sven Luther
