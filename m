Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 7B3F6DDEC4
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2007 20:06:12 +1100 (EST)
Date: Mon, 5 Mar 2007 10:06:06 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
In-Reply-To: <1173085328.8184.70.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0703051004390.18075@pademelon.sonytel.be>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
	<200703041959.46872.arnd@arndb.de>
	<1173085328.8184.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 Mar 2007, Benjamin Herrenschmidt wrote:
> On Sun, 2007-03-04 at 19:59 +0100, Arnd Bergmann wrote:
> > On Sunday 04 March 2007, Benjamin Herrenschmidt wrote:
> > > On Sun, 2007-03-04 at 15:07 +0100, Arnd Bergmann wrote:
> > > > On Sunday 04 March 2007 07:04:44 Stephen Rothwell wrote:
> > > > >  config PCI
> > > > >         bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \ 
> > > > > -               || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3 
> > > > > +               || PPC_MPC52xx || (EMBEDDED &&  (PPC_PSERIES || PPC_ISERIES)) \ 
> > > > > +               || MPC7448HPC2 || PPC_PS3 
> > > > 
> > > I dislike the giant conditional though.
> > 
> > How about changing it to
> > 
> > config PCI_ENABLE
> > 	bool
> 
> Call it PCI_CAPABLE rather...

And I guess PS3 can be removed from the list, as we don't use fake PCI anymore.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
