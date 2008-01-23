Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 01CF6DDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 07:30:28 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5358786wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 12:30:27 -0800 (PST)
Message-ID: <9e4733910801231230o234a1422u1bf857498b819a02@mail.gmail.com>
Date: Wed, 23 Jan 2008 15:30:27 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH 3/3] Add device tree compatible aliases to i2c drivers
In-Reply-To: <4797A127.8070401@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020916.31675.98481.stgit@terra.home>
	<4797A127.8070401@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/23/08, Matt Sealey <matt@genesi-usa.com> wrote:
>
>
> Jon Smirl wrote:
> > --- a/drivers/i2c/chips/tps65010.c
> > +++ b/drivers/i2c/chips/tps65010.c
> > @@ -571,6 +571,10 @@ static const struct i2c_device_id tps65010_id[] = {
> >       { "tps65011", TPS65011 },
> >       { "tps65012", TPS65012 },
> >       { "tps65013", TPS65013 },
> > +     OF_ID("ti,tps65010", TPS65010)
> > +     OF_ID("ti,tps65011", TPS65011)
> > +     OF_ID("ti,tps65012", TPS65012)
> > +     OF_ID("ri,tps65013", TPS65013)
> >       { },
>
> ti, ti, ti, ri?
>
> > --- a/drivers/rtc/rtc-ds1307.c
> > +++ b/drivers/rtc/rtc-ds1307.c
> > @@ -129,6 +129,12 @@ static const struct i2c_device_id ds1307_id[] = {
> >       { "ds1339", ds_1339 },
> >       { "ds1340", ds_1340 },
> >       { "m41t00", m41t00 },
> > +     OF_ID("dallas,ds1307", ds_1307)
> > +     OF_ID("dallas,ds1337", ds_1337)
> > +     OF_ID("dallas,ds1338", ds_1338)
> > +     OF_ID("dallas,ds1339", ds_1339)
> > +     OF_ID("dallas,ds1340", ds_1340)
> > +     OF_ID("stm,m41t00", m41t00)
> >       {},
> >  };
>
> The convention is to use the stock ticker, capitalized, if a company
> has one, I guess dallas is MXIM these days, but dallas is a good
> substitute based on the fact that most people still remember Dallas
> clock chips and so on from the Ancient Days. STMicroelectronics is STM.
> I couldn't care less about case sensitivity, but the stock ticker
> thing was always a good idea.. it gives a sort of grounding in reality
> for the manufacturer names.

I'll put in whatever the Open Firmware police tell me to. We just all
need to come to an agreement.


> Are we still following this convention or are the names of devices
> simply arbitrarily defined by Linux kernel developers now?
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
>


-- 
Jon Smirl
jonsmirl@gmail.com
