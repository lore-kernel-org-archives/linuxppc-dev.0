Return-Path: <HPENNER@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27E12DDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 23:02:42 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l1JC2ZYR116980
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 12:02:35 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1JC2ZZ62216038
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 13:02:35 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1JC2Y57015393
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 13:02:35 +0100
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BE96@az33exm25.fsl.freescale.net>
Subject: RE: [PATCH 15/16] Add device tree for Ebony
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Message-ID: <OFBB5AA1C7.5D588F77-ONC1257287.0041DACF-41257287.00422702@de.ibm.com>
From: Hartmut Penner <HPENNER@de.ibm.com>
Date: Mon, 19 Feb 2007 13:02:33 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Heiko J Schick <SCHICKHJ@de.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



"Yoder Stuart-B08248" <stuart.yoder@freescale.com> wrote on 02/16/2007
05:47:51 PM:

>
> > Harmut Pennter wrote:
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 15.02.2007
> 22:41:08:
> >
> > >
> > > > Is there a DCR binding?  Are the dcr-* properties documented
> > > > anywhere:
> > > >
> > > > dcr-reg         // what do these fields mean?
> > > > dcr-parent      // in case there is more than one controller??
> > > > dcr-controller
> > > > dcr-access-method = "native"   // what are the other options?
> > >
> > > Yes, we wrote a binding document though I can't find it now. Hartmut
> or
> > > Heiko, do you have the latest DCR binding document at hand ?
> >
> > I found some draft. It is as you discribed here. I need to check, how
> close this
> > is to what we did at last. Also we need place were we can publish such
> a document ...
>
> Harmut,
>
> I would suggest creating a text file and putting this in
> Documentation/powerpc along with booting-without-of.txt and
> mpc52xx-device-tree-bindings.txt.
>
> That is the closest place we have to a centralized repository
> at this point.  Hopefully, in the near future power.org will
> provide a repository outside of the Linux kernel source.

Stuart,
      I have looked into the document and the FW code and will update the
document with
our latest de-facto bindings we developed together with Ben. Were and how
we put it out,
I need to discuss first internally.

      regards, Hartmut

>
> Stuart
