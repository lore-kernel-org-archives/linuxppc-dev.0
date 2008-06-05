Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 827E9DE84A
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:37:54 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so143850anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Jun 2008 09:37:53 -0700 (PDT)
Message-ID: <fa686aa40806050937pf08ca72uea9b46d2e9b2af03@mail.gmail.com>
Date: Thu, 5 Jun 2008 10:37:42 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
In-Reply-To: <48481373.8010706@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200806041706.21557.sr@denx.de>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<4848028B.5060105@freescale.com>
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>
	<48480987.1070701@freescale.com>
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>
	<484810A3.5070301@freescale.com>
	<20080605112122.0381a338@zod.rchland.ibm.com>
	<48481373.8010706@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 5, 2008 at 10:25 AM, Timur Tabi <timur@freescale.com> wrote:
> Josh Boyer wrote:
>
>> And it does.  It does so by the unique "regs" properties and
>> unit-names.  You can assign the index that the i2c subsystem needs
>> based on probe order, like I already said.
>
> The probe order is not sufficient on platforms that specifically enumerate their
> I2C (or whatever) devices.  For instance, in order to do audio playback on an
> MPC8610, SSI1 needs to use DMA channel 0.  The SSI driver specifically needs to
> find the register addresses for DMA channel 0.

then you use a phandle for that; but that entirely different from bus
enumeration because it describes a real property of the hardware.

Cheers,
g.

>
> --
> Timur Tabi
> Linux kernel developer at Freescale
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
