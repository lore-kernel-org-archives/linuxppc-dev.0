Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17637.1235.223857.925995@cargo.ozlabs.ibm.com>
Date: Fri, 18 Aug 2006 10:07:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: Outstanding Patches Ping 
In-Reply-To: <E1GDhtO-0002Mk-2j@jdl.com>
References: <1155679316.10054.129.camel@cashmere.sps.mot.com>
	<17636.3393.801267.484874@cargo.ozlabs.ibm.com>
	<E1GDhtO-0002Mk-2j@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> > >     - 08/09 Offer PCI as a CONFIG choice for PPC_86xx
> > 
> > I'll push it to powerpc.git (to go in 2.6.19) shortly, unless you
> > particularly want it and your "Allow MPC8641 HPCN to build with
> > CONFIG_PCI disabled too" patches in 2.6.18.
> 
> My preference would be to have them both in 18 if possible.

The "Allow MPC8641 HPCN to build with CONFIG_PCI disabled too" patch
depends on your "Rewrite the PPC 86xx IRQ handling to use Flat Device
Tree" which isn't in the queue for 2.6.18, and doesn't apply for
2.6.18 since it depends on the constifying of get_property.

Paul.
