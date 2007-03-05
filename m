Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAC08DDDCA
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2007 20:02:39 +1100 (EST)
Subject: Re: [PATCH 4/6] [POWERPC] allow pSeries to build without CONFIG_PCI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200703041959.46872.arnd@arndb.de>
References: <20070304165839.4d2bf50b.sfr@canb.auug.org.au>
	<200703041507.06307.arnd@arndb.de>
	<1173033826.8184.68.camel@localhost.localdomain>
	<200703041959.46872.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 05 Mar 2007 10:02:08 +0100
Message-Id: <1173085328.8184.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-03-04 at 19:59 +0100, Arnd Bergmann wrote:
> On Sunday 04 March 2007, Benjamin Herrenschmidt wrote:
> > On Sun, 2007-03-04 at 15:07 +0100, Arnd Bergmann wrote:
> > > On Sunday 04 March 2007 07:04:44 Stephen Rothwell wrote:
> > > >  config PCI
> > > >         bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \ 
> > > > -               || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3 
> > > > +               || PPC_MPC52xx || (EMBEDDED &&  (PPC_PSERIES || PPC_ISERIES)) \ 
> > > > +               || MPC7448HPC2 || PPC_PS3 
> > > 
> > I dislike the giant conditional though.
> 
> How about changing it to
> 
> config PCI_ENABLE
> 	bool

Call it PCI_CAPABLE rather...

Ben.
