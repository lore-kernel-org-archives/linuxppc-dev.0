Return-Path: <dgibson@ozlabs.org>
Date: Fri, 1 Feb 2008 18:32:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to i2c drivers
Message-ID: <20080201073212.GA18684@localhost.localdomain>
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020916.31675.98481.stgit@terra.home>
	<4797A127.8070401@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4797A127.8070401@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 23, 2008 at 08:18:47PM +0000, Matt Sealey wrote:
> 
> 
> Jon Smirl wrote:
> > --- a/drivers/i2c/chips/tps65010.c
> > +++ b/drivers/i2c/chips/tps65010.c
> > @@ -571,6 +571,10 @@ static const struct i2c_device_id tps65010_id[] = {
> >  	{ "tps65011", TPS65011 },
> >  	{ "tps65012", TPS65012 },
> >  	{ "tps65013", TPS65013 },
> > +	OF_ID("ti,tps65010", TPS65010)
> > +	OF_ID("ti,tps65011", TPS65011)
> > +	OF_ID("ti,tps65012", TPS65012)
> > +	OF_ID("ri,tps65013", TPS65013)
> >  	{ },
> 
> ti, ti, ti, ri?
> 
> > --- a/drivers/rtc/rtc-ds1307.c
> > +++ b/drivers/rtc/rtc-ds1307.c
> > @@ -129,6 +129,12 @@ static const struct i2c_device_id ds1307_id[] = {
> >  	{ "ds1339", ds_1339 },
> >  	{ "ds1340", ds_1340 },
> >  	{ "m41t00", m41t00 },
> > +	OF_ID("dallas,ds1307", ds_1307)
> > +	OF_ID("dallas,ds1337", ds_1337)
> > +	OF_ID("dallas,ds1338", ds_1338)
> > +	OF_ID("dallas,ds1339", ds_1339)
> > +	OF_ID("dallas,ds1340", ds_1340)
> > +	OF_ID("stm,m41t00", m41t00)
> >  	{},
> >  };
> 
> The convention is to use the stock ticker, capitalized, if a company
> has one, I guess dallas is MXIM these days, but dallas is a good
> substitute based on the fact that most people still remember Dallas
> clock chips and so on from the Ancient Days. STMicroelectronics is STM.
> I couldn't care less about case sensitivity, but the stock ticker
> thing was always a good idea.. it gives a sort of grounding in reality
> for the manufacturer names.

The stock ticker is a recent convention.  "dallas," has been used in
existing IEEE1275 bindings, which to my mind trumps newer conventions.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
