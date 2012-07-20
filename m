Return-Path: <r61911@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 070E62C0388
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2012 19:31:38 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: RE: PCIE Hotplug on P2010(mpc85xx) ?
Date: Fri, 20 Jul 2012 09:31:31 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079C3332@039-SN2MPN1-013.039d.mgd.msft.net>
References: <OF18324FBA.9272A499-ONC1257A36.006C006E-C1257A36.006C6943@transmode.se>
 <3E027F8168735B46AC006B1D0C7BB002079C326B@039-SN2MPN1-013.039d.mgd.msft.net>
 <OFBF3755D8.5571BBB7-ONC1257A41.002F199A-C1257A41.002F3A5A@transmode.se>
In-Reply-To: <OFBF3755D8.5571BBB7-ONC1257A41.002F199A-C1257A41.002F3A5A@transmode.se>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> Sent: Friday, July 20, 2012 16:36 PM
> To: Zang Roy-R61911
> Cc: linuxppc-dev@ozlabs.org
> Subject: RE: PCIE Hotplug on P2010(mpc85xx) ?
>=20
> Zang Roy-R61911 <r61911@freescale.com> wrote on 2012/07/20 10:15:46:
> >
> > I do not think P2010 has a functional pciehp module in the pcie
> controller.
> > Roy
>=20
> Maybe there is, see my latest mail to the list (today) titled:
> mpc8xxx PCIe hotplug needs fixing, some clues
No. if you check the hotplug register in configuration space in
P2010, which missrd some important bit define for hotplug, for example,
"Data Link Layer State Changed" in slot status register.
And more, hotplug needs extra hardware pin in the silicon, which is missing=
 for P2010.
Roy
>=20
> >
> > > -----Original Message-----
> > > From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> > > fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Joakim Tjernl=
und
> > > Sent: Tuesday, July 10, 2012 3:44 AM
> > > To: linuxppc-dev@ozlabs.org
> > > Subject: PCIE Hotplug on P2010(mpc85xx) ?
> > >
> > >
> > > Trying to get the pciehp module to work on the above system.
> > > I can see it register but then nothing happens. I suspect there is
> > > something missing that I don't see ATM. Any clues what to look for?
> > >
> > >  Jocke
> > >
> > > _______________________________________________
> > > Linuxppc-dev mailing list
> > > Linuxppc-dev@lists.ozlabs.org
> > > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> >
>=20
