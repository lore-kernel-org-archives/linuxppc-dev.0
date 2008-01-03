Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 687E9DDF39
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 05:13:58 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1146843anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jan 2008 10:13:57 -0800 (PST)
Message-ID: <fa686aa40801031013w54b15286u8e6e2561219422f2@mail.gmail.com>
Date: Thu, 3 Jan 2008 11:13:57 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477D2150.4020506@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<9e4733910801010942y47e4cdbfge5e0d3e44ab96760@mail.gmail.com>
	<477BAB67.4080003@freescale.com>
	<9e4733910801020734n115888cbt86351f67f2311629@mail.gmail.com>
	<477D2150.4020506@freescale.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, alsa-devel@alsa-project.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/3/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
> > Don't we want to follow the device tree policy of putting the device
> > on the controlling bus and then link it to the data bus?
>
> Normally, that sounds like a good idea, but the cs4270 is an I2S device first,
> and an I2C device second.  I need to be able to find that codec from the I2S
> node.  My I2S driver would not know to scan all I2C devices to find the codec.

The device tree is a description of the hardware; not software.  It's
not a good idea to break with convention due to current driver
architecture.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
