Return-Path: <neko@genesi-usa.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.185])
	by ozlabs.org (Postfix) with ESMTP id EE480DE845
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:04:31 +1000 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so496609tia.13
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 10:04:29 -0700 (PDT)
Message-ID: <480CC914.1050903@genesi-usa.com>
Date: Mon, 21 Apr 2008 18:04:20 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>
	<fa686aa40804181553q622b3c1fi7a302712abe79be1@mail.gmail.com>
	<4809DF54.2080609@genesi-usa.com>
	<200804211002.07452.jbe@pengutronix.de>
In-Reply-To: <200804211002.07452.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Juergen Beisert wrote:

> Please don't forget what Sylvian said about this driver: "I also completely 
> skipped the 5200 (not B) support ..." and your own "I think it should be left 
> noted here that the CCR size changed from 16 bits to 32 bits from 5200 to 
> 5200B in order to reduce confusion.". Its not solved yet. So any user of an 
> old MPC5200 will be surprised...

+static struct of_device_id mpc52xx_ac97_of_match[] = {
+	{
+		.type		= "sound",
+		.compatible	= "mpc5200b-psc-ac97",	/* B only for now */
+	},
+};

It shouldn't even load, the matchlist is 5200b only..? No alarms and no surprises.. :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
