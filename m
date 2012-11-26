Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 9F6212C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 00:52:21 +1100 (EST)
Subject: Re: [PATCH 065/493] i2c: remove use of __devexit_p
To: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 26 Nov 2012 08:52:18 -0500
In-Reply-To: <20121122214915.GD14851@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20121126135218.45F6780157@viridian.itc.virginia.edu>
From: wfp5p@viridian.itc.virginia.edu (Bill Pemberton)
Cc: Rudolf Marek <r.marek@assembler.cz>, Tony Lindgren <tony@atomide.com>,
 gregkh@linuxfoundation.org, Olof Johansson <olof@lixom.net>,
 linux-omap@vger.kernel.org, "Mark M. Hoffman" <mhoffman@lightlink.com>,
 linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
 Barry Song <baohua.song@csr.com>, Jean Delvare <khali@linux-fr.org>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfram Sang writes:
> 
> 
> --osDK9TLjxFScVI/L
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Tue, Nov 20, 2012 at 02:46:21PM +0100, Jean Delvare wrote:
> > On Mon, 19 Nov 2012 13:20:14 -0500, Bill Pemberton wrote:
> > > CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> > > needed.
> >=20
> > As mentioned on the lm-sensors list for hwmon patches already, I think
> > it would be much clearer to not split __devexit, __devexit_p, __devinit
> > etc. removal into separate patches. One patch per subsystem would be
> > easier to review and apply. If patches grow too large then you'd rather
> > split in a different direction, for example drivers/i2c/muxes vs.
> > drivers/i2c/busses or even grouped by related bus drivers (see entries
> > "I2C OVER PARALLEL PORT" and "I2C/SMBUS CONTROLLER DRIVERS FOR PC" in
> > MAINTAINERS for examples of meaningful groups.)
> 
> I agree with Jean here. Is there a V2 planned? With a change like this?
> 

Yes, my plan is to redo the patches for the i2c subsystem.

-- 
Bill
