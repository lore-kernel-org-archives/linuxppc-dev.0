Return-Path: <r61911@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 138A02C030A
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2012 18:15:52 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: RE: PCIE Hotplug on P2010(mpc85xx) ?
Date: Fri, 20 Jul 2012 08:15:46 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB002079C326B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <OF18324FBA.9272A499-ONC1257A36.006C006E-C1257A36.006C6943@transmode.se>
In-Reply-To: <OF18324FBA.9272A499-ONC1257A36.006C006E-C1257A36.006C6943@transmode.se>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I do not think P2010 has a functional pciehp module in the pcie controller.
Roy

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-bounces+tie-
> fei.zang=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Joakim Tjernlund
> Sent: Tuesday, July 10, 2012 3:44 AM
> To: linuxppc-dev@ozlabs.org
> Subject: PCIE Hotplug on P2010(mpc85xx) ?
>=20
>=20
> Trying to get the pciehp module to work on the above system.
> I can see it register but then nothing happens. I suspect there is
> something missing that I don't see ATM. Any clues what to look for?
>=20
>  Jocke
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
