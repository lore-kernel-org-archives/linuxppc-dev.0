Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 01386DDEF3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 08:35:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 04 Feb 2009 22:35:31 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090204205941.GB17771@iram.es>
Message-ID: <20090204213531.164090@gmx.net>
MIME-Version: 1.0
References: <20090202212139.69160@gmx.net> <20090202213910.258290@gmx.net>
	<1233719407.16867.164.camel@pasglop> <20090204205941.GB17771@iram.es>
Subject: Re: [PATCH v2 1/4] Add platform support for AmigaOne
To: Gabriel Paubert <paubert@iram.es>, benh@kernel.crashing.org
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
> Datum: Wed, 4 Feb 2009 21:59:41 +0100
> Von: Gabriel Paubert <paubert@iram.es>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
> Betreff: Re: [PATCH v2 1/4] Add platform support for AmigaOne

> On Wed, Feb 04, 2009 at 02:50:07PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > > + hose->first_busno = bus_range ? bus_range[0] : 0;
> > > + hose->last_busno = bus_range ? bus_range[1] : 0xff;
> > > +
> > > + setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);
> > 
> > Minor in the context of amigaone but still... the above should come
> > from the device-tree... I suppose those are really just IO space
> > addresses cf8 and cfc, in which case, an option is to call that first:
> 
> Hmm, the first is feC...,the other one feE..., 2Mbytes apart.
> 
> I don't know the hardware but I've never seen something like that.
> Of course a typo is always a possibility...
The Pegasos 1 uses the same northbridge and chrp_find_bridges() calls
setup_indirect_pci() with the same addresses.

Gerhard

-- 
Jetzt 1 Monat kostenlos! GMX FreeDSL - Telefonanschluss + DSL 
für nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
