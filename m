Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 659492C0200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Sep 2013 00:44:30 +1000 (EST)
Message-ID: <1378997052.2536.5.camel@snotra.buserror.net>
Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Thu, 12 Sep 2013 09:44:12 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B150748AA@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378882632-9053-1-git-send-email-Yuantian.Tang@freescale.com>
 <1378948229.12204.486.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150748AA@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-Leo-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 20:31 -0500, Tang Yuantian-B29983 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2013=E5=B9=B49=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E5=9B=9B =
9:10
> > To: Tang Yuantian-B29983
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org;
> > devicetree@vger.kernel.org; Li Yang-Leo-R58472
> > Subject: Re: [PATCH v4] powerpc/mpc85xx: Update the clock device tree
> > nodes
> >=20
> > This description of "reg" is overly specific (assumes how the parent
> > node's ranges are set up), incomplete (there's a size as well as the
> > offset), and does not apply to the clockgen node itself (you probably
> > shouldn't lump them together like this).
> >=20
> Do you mean I should explain the REG of clockgen and its child node res=
pectively?
>=20
> > > +- clocks : shall be the input parent clock phandle for the clock.
> >=20
> > Not required on the clockgen node
> >=20
> Required by child node of clockgen.

My point is that you're lumping several different types of nodes
together with one binding, when some parts of the binding are not
applicable to the clockgen node.

-Scott
