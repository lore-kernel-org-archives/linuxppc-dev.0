Return-Path: <david-b@pacbell.net>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by ozlabs.org (Postfix) with SMTP id 9D509DDF5D
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:12:14 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH] spi_mpc83xx: test below 0 on unsigned
	irq in mpc83xx_spi_probe()
Date: Wed, 30 Apr 2008 15:12:10 -0700
References: <480F99D5.7070300@tiscali.nl>
	<7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
In-Reply-To: <7C711FFF-E1C5-4286-93A8-382055C6760C@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200804301512.11317.david-b@pacbell.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Roel Kluin <12o3l@tiscali.nl>, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 23 April 2008, Kumar Gala wrote:
> 
> On Apr 23, 2008, at 3:19 PM, Roel Kluin wrote:
> > mpc83xx_spi->irq is unsigned, so the test fails
> >
> > Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Any reason to not just make mpc83xx_spi->irq be "int",
following normal practice everywhere?  If not, I'll
roll that into the patch from Joakim Tjernlund...

- Dave
