Date: Thu, 17 Aug 2000 13:37:27 -0700
From: Matt Porter <mporter@mvista.com>
To: tom_gall@vnet.ibm.com
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
Message-ID: <20000817133727.A19393@cx258813-a.chnd1.az.home.com>
References: <200008151939.VAA00754@piglet.grunz.lu> <3999CF3E.561EB9C8@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3999CF3E.561EB9C8@vnet.ibm.com>; from tom_gall@vnet.ibm.com on Tue, Aug 15, 2000 at 11:16:14PM +0000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Aug 15, 2000 at 11:16:14PM +0000, tom_gall@vnet.ibm.com wrote:
>
> Michel Lanners wrote:
> >
> > Hi Tom,
> >
> > On  15 Aug, this message from tom_gall@vnet.ibm.com echoed through cyberspace:
> > >   Just a stupid question here for those of you that have Mac hardware. Of all
> > > the Mac hardware in existance right now, all Macs have at most one PCI bus
> > > right?
>
> Hi All,
>
>   I thank you much for the information. It took me a little bit but as I've been
> looking at the PCI code I ran across the pmac PCI implementation which
> definately has support for more than one PCI bus.
>
>   Where I'm coming from is getting the same thing working on IBM PowerPC
> hardware for multiple pythons... fun fun fun...

Do you mean two separate physical buses like on the CPC710 PHB?  If so,
then check out the SBS K2 LSP code in MontaVista CDK1.2 release
(ftp.mvista.com).  There's some extra layering in their to allow
for kernel resident PCI autoconfiguration before the generic bus scan
as well as transparent handling of config space accesses via the different
CFGA/CFGD addresses.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
