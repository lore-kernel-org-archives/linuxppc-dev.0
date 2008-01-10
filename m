Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by ozlabs.org (Postfix) with ESMTP id 0B122DE0AF
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 07:24:11 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so187640anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 12:24:10 -0800 (PST)
Message-ID: <fa686aa40801101224p298e60bcheb622324c80690ea@mail.gmail.com>
Date: Thu, 10 Jan 2008 13:24:10 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <47867C80.4050408@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
	<20080107182853.GA17312@sirena.org.uk>
	<20080110034919.GI17816@localhost.localdomain>
	<9e4733910801092141m5d4476d0l1c081307fd5c1969@mail.gmail.com>
	<1199961015.19903.270.camel@localhost.localdomain>
	<47863C31.50309@freescale.com>
	<fa686aa40801100801p3da98eecn44401b17fe652da8@mail.gmail.com>
	<478641E3.5070404@freescale.com>
	<9e4733910801101210w5846bb4ds38a603a489ef0522@mail.gmail.com>
	<47867C80.4050408@freescale.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lg@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
> > Isn't your codec is i2c controlled? Where does the main node for the
> > code live, i2c bus or ssi bus? What does the link between the buses
> > look like for pointing to the codec entry?
>
> The CS4270 driver is "old style", which means it probes all possible I2C
> addresses until it finds a hit, and then stops.  This has all the obvious
> drawbacks, but I'm stuck with that design for now.
>
> > What about fsl,ssi being too generic for a compatible type?
>
> Already fixed:
>
>                 ssi@16000 {
>                         compatible = "fsl,mpc8610-ssi";

Nit: node name should be either i2s@16000 (the mode that it is in), or
sound@16000 (if you feel that this node encapsulates the concept of a
sound device enough).

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
