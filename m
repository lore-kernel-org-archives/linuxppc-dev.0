Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7ACE8DDF7F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:20:38 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 07 Jan 2009 16:20:35 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <fa686aa40901070707h6c10186bv6c7953e7a63c9f3f@mail.gmail.com>
Message-ID: <20090107152035.270110@gmx.net>
MIME-Version: 1.0
References: <20090107135457.234150@gmx.net> <20090107140334.299940@gmx.net>
	<fa686aa40901070707h6c10186bv6c7953e7a63c9f3f@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc: Bootwrapper and serial console support for
	AmigaOne
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 7 Jan 2009 08:07:14 -0700
> Von: "Grant Likely" <grant.likely@secretlab.ca>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: [PATCH 3/5] powerpc: Bootwrapper and serial console support for AmigaOne

> On Wed, Jan 7, 2009 at 7:03 AM, Gerhard Pircher <gerhard_pircher@gmx.net>
> wrote:
> > diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> > index 8b3607c..f2156f0 100644
> > --- a/arch/powerpc/boot/serial.c
> > +++ b/arch/powerpc/boot/serial.c
> > @@ -117,7 +117,8 @@ int serial_console_init(void)
> >        if (devp == NULL)
> >                goto err_out;
> >
> > -       if (dt_is_compatible(devp, "ns16550"))
> > +       if (dt_is_compatible(devp, "ns16550") ||
> > +           dt_is_compatible(devp, "pnpPNP,501"))
> >                rc = ns16550_console_init(devp, &serial_cd);
> 
> Why not just claim "ns16550" compatibility in the device tree node?
It was suggested that I should use PNP identifiers for all ISA devices, as
these are part of a real PCI2ISA bridge (when I sent the previous version
or these patches).

Gerhard

-- 
Sensationsangebot verlängert: GMX FreeDSL - Telefonanschluss + DSL 
für nur 16,37 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K1308T4569a
