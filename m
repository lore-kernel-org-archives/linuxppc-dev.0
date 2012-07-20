Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C2BB82C0358
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2012 18:35:55 +1000 (EST)
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB002079C326B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <OF18324FBA.9272A499-ONC1257A36.006C006E-C1257A36.006C6943@transmode.se>
 <3E027F8168735B46AC006B1D0C7BB002079C326B@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: RE: PCIE Hotplug on P2010(mpc85xx) ?
To: Zang Roy-R61911 <r61911@freescale.com>
Message-ID: <OFBF3755D8.5571BBB7-ONC1257A41.002F199A-C1257A41.002F3A5A@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 20 Jul 2012 10:35:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zang Roy-R61911 <r61911@freescale.com> wrote on 2012/07/20 10:15:46:
>
> I do not think P2010 has a functional pciehp module in the pcie controller.
> Roy

Maybe there is, see my latest mail to the list (today) titled:
mpc8xxx PCIe hotplug needs fixing, some clues

>
> > -----Original Message-----
> > From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> > fei.zang=freescale.com@lists.ozlabs.org] On Behalf Of Joakim Tjernlund
> > Sent: Tuesday, July 10, 2012 3:44 AM
> > To: linuxppc-dev@ozlabs.org
> > Subject: PCIE Hotplug on P2010(mpc85xx) ?
> >
> >
> > Trying to get the pciehp module to work on the above system.
> > I can see it register but then nothing happens. I suspect there is
> > something missing that I don't see ATM. Any clues what to look for?
> >
> >  Jocke
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
