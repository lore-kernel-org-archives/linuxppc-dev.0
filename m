Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 7296F67D7A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 03:25:48 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 68so426390wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jul 2005 10:25:47 -0700 (PDT)
Message-ID: <528646bc0507281025661032ba@mail.gmail.com>
Date: Thu, 28 Jul 2005 11:25:47 -0600
From: Grant Likely <glikely@gmail.com>
To: Yuli Barcohen <yuli@arabellasw.com>,
	Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <17124.61231.988084.399036@astp0002.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc050723070419b8f914@mail.gmail.com>
	<17124.46441.807442.139506@astp0002.localdomain>
	<63137.192.100.124.219.1122287941.squirrel@www.iti.fi>
	<17124.61231.988084.399036@astp0002.localdomain>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 0/3] Support for SPI busses and devices
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/25/05, Yuli Barcohen <yuli@arabellasw.com> wrote:
> >>>>> Kate Alhola writes:
>=20
>     Yuli> SPI is very similar to I2C IMHO. I'm not sure separate
>     Yuli> infrastructure is needed. We support SPI on MPC8xx/82xx/85xx
>     Yuli> using the standard I2C infrastructure. I only had to add a
>     Yuli> couple of IOCTLs to control clock frequency and polarity. Due
>     Yuli> to such an implementation, lm-sensors work OK with SPI
>     Yuli> temperature sensors, for example.
>=20
>     Kate> SPI IS wery similar than I2C and for this reason it looks a
>     Kate> like that all SPI subsystems implementations are based on I2C
>     Kate> code.

Thanks for the comments everyone.  I had seen the first cut at an SPI
subsystem on the lkml, but I hadn't seen the revised patch.  My
understanding from GregKH's comments on the first patch is that i2c is
a bit of a mess:

>From http://lkml.org/lkml/2005/5/31/251
"The i2c dev interface is a mess, please don't duplicate it, there is
no need to do so."

What is current opinion on the i2c subsystem?  Did I misunderstand
Greg's I2C comments?  I put together the SPI patch as an alternative
implementation that matches the current coding conventions (as I
understand them).

Yuli, are there any plans to submit your i2c changes to support SPI
back to mainline?

I've now got to go back and review the revised SPI patch on the LKML.

Thanks again,
g.
