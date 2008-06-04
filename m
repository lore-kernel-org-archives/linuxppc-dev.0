Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id B5C58DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 05:34:31 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-ibm_iic: Remove deprecated OCP style part of the
	driver
Date: Wed, 4 Jun 2008 21:33:18 +0200
References: <1212592932-24031-1-git-send-email-sr@denx.de>
	<20080604210400.0d7abb8e@hyperion.delvare>
In-Reply-To: <20080604210400.0d7abb8e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806042133.18215.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 June 2008, Jean Delvare wrote:
> On Wed,  4 Jun 2008 17:22:12 +0200, Stefan Roese wrote:
> > The deprecated OCP style driver part is used by the "old" arch/ppc
> > platform. This platform is scheduled for removal in June/July this year.
> > This patch now removes the OCP driver part from the IBM I2C driver.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> >  drivers/i2c/busses/i2c-ibm_iic.c |  181
> > -------------------------------------- 1 files changed, 0 insertions(+),
> > 181 deletions(-)
>
> Applied, queued for 2.6.27, thanks Stefan.

Thanks. I'll post some smaller follow-up patches probably tomorrow.

> BTW, would you happen to know if read-only EEPROMs such as SPD or EDID
> can be found on the i2c-ibm_iic adapters?

Yes. Some PPC4xx boards are equipped with DIMM modules. Those SPD EEPROM's are 
connected to the I2C bus controller by the i2c-ibm_iic driver.

Best regards,
Stefan
