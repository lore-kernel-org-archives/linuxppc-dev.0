Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 1832FDDE0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 12:34:52 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1482840rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Nov 2007 17:34:51 -0800 (PST)
Message-ID: <9e4733910711051734m7cf1fac0y5fb39feb37bad548@mail.gmail.com>
Date: Mon, 5 Nov 2007 20:34:51 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [RFC] Rework of i2c-mpc.c - Freescale i2c driver
In-Reply-To: <472F7247.9070106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711050714l2aa3a5eeqf5327c3e0d8ca490@mail.gmail.com>
	<472F7247.9070106@freescale.com>
Cc: Tjernlund <tjernlund@tjernlund.se>, linuxppc-dev@ozlabs.org,
	Jean Delvare <khali@linux-fr.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/5/07, Scott Wood <scottwood@freescale.com> wrote:
> > +static struct of_platform_driver mpc_i2c_driver = {
> > +     .owner          = THIS_MODULE,
> > +     .name           = DRV_NAME,
> > +     .match_table    = mpc_i2c_of_match,
> > +     .probe          = mpc_i2c_probe,
> > +     .remove         = __devexit_p(mpc_i2c_remove),
> > +     .driver         = {
> > +             .name   = DRV_NAME,
> >       },
> >  };
>
> Do we still need .name if we have .driver.name?

This is a general question, if of_platform_driver doesn't need .name
it should be removed from the structure.

-- 
Jon Smirl
jonsmirl@gmail.com
