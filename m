Return-Path: <bunk@kernel.org>
Received: from smtp6.pp.htv.fi (smtp6.pp.htv.fi [213.243.153.40])
	by ozlabs.org (Postfix) with ESMTP id 7B399DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Aug 2008 19:23:32 +1000 (EST)
Date: Mon, 4 Aug 2008 12:22:15 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Li Yang <LeoLi@freescale.com>
Subject: Re: [2.6 patch] sata_fsl.c: fix 8315DS workaround
Message-ID: <20080804092215.GE6088@cs181140183.pp.htv.fi>
References: <20080804084611.GA6088@cs181140183.pp.htv.fi>
	<A94B04433DF4F44C9C2AB5DEFBF29A4E05E1E7@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A94B04433DF4F44C9C2AB5DEFBF29A4E05E1E7@zch01exm26.fsl.freescale.net>
Cc: Jeff Garzik <jeff@garzik.org>, linuxppc-dev@ozlabs.org,
	Kalra Ashish <ashish.kalra@freescale.com>, linux-ide@vger.kernel.org,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 04, 2008 at 04:55:37PM +0800, Li Yang wrote:
> > -----Original Message-----
> > From: Adrian Bunk [mailto:bunk@kernel.org] 
> > Sent: Monday, August 04, 2008 4:46 PM
> > To: Kalra Ashish; Li Yang; Jeff Garzik; galak@kernel.crashing.org
> > Cc: linuxppc-dev@ozlabs.org; linux-ide@vger.kernel.org; 
> > Robert P. J. Day
> > Subject: [2.6 patch] sata_fsl.c: fix 8315DS workaround
> > 
> > Commit e7eac96e8f0e57a6e9f94943557bc2b23be31471 
> > (ata/sata_fsl: Move MPC8315DS link speed limit workaround to 
> > specific ifdef) aimed at limiting the workaround only to the 
> > affected hardware, but since the #ifdef used a nonexisting 
> > kconfig variable it actually killed the workaround.
> 
> This workaround is only for MPC8315_DS board which is not supported in the main line yet.  We can remove the workaround if we need to do something here.

Thanks, in this case my patch is complete crap.

There's no need for any action.

> - Leo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
