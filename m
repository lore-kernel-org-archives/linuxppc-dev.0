Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E75E9DDF25
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:55:48 +1000 (EST)
Date: Mon, 7 Jul 2008 18:55:44 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] i2c-ibm_iic: Remove deprecated OCP style part of thedriver
Message-ID: <20080707185544.7335b108@lappy.seanm.ca>
In-Reply-To: <20080604210400.0d7abb8e@hyperion.delvare>
References: <1212592932-24031-1-git-send-email-sr@denx.de>
	<20080604210400.0d7abb8e@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008 21:04:00 +0200
"Jean Delvare" <khali@linux-fr.org> wrote:

> On Wed,  4 Jun 2008 17:22:12 +0200, Stefan Roese wrote:
> > The deprecated OCP style driver part is used by the "old" arch/ppc
> > platform. This platform is scheduled for removal in June/July this
> > year. This patch now removes the OCP driver part from the IBM I2C
> > driver.
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> >  drivers/i2c/busses/i2c-ibm_iic.c |  181
> > -------------------------------------- 1 files changed, 0
> > insertions(+), 181 deletions(-)
> 
> Applied, queued for 2.6.27, thanks Stefan.
> 
> BTW, would you happen to know if read-only EEPROMs such as SPD or EDID
> can be found on the i2c-ibm_iic adapters?
> 

Jean, where is this patch queued? I have a patch for the iic driver and
it would probably be easiest if I diffed against what you have.

Cheers,
   Sean
