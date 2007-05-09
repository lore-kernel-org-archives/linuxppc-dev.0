Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 921ADDDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 12:40:41 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l491cwMk011479
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 21:38:58 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l492eYRP503354
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 22:40:34 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l492eYt6018326
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 22:40:34 -0400
Subject: RE: [PATCH v4 0/7] Add support for 750CL Holly board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E753C30@zch01exm23.fsl.freescale.net>
References: <1178572962.2990.197.camel@zod.rchland.ibm.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E753A11@zch01exm23.fsl.freescale.net>
	<20070508104640.GM23995@crusty.rchland.ibm.com>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E753B9F@zch01exm23.fsl.freescale.net>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E753C30@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 08 May 2007 21:34:49 -0500
Message-Id: <1178678089.3453.51.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 10:19 +0800, Zang Roy-r61911 wrote:
> > > On Tue, May 08, 2007 at 11:45:05AM +0800, Zang Roy-r61911 wrote:
> > > > > 
> > > > > Hi All,
> > > > > 
> > > > > This is round 4 of the patches to support the 750CL Holly 
> > > board, and
> > > > > hopefully the last.  They also fix one of the PCI issues 
> > > I was seeing.
> > > > Sorry, Maybe I missed your previous comment.
> > > > What is the PCI issue? Associated with your board or tsi108/9 ?
> > > 
> > > Mostly it was the fact that PIBS (the low level boot 
> > > firmware) setup the PCI
> > > bridge in an odd fashion.  The other small issue was that the 
> > > TSI PCI bridge
> > > was not being designated as the primary.  Both of these were 
> > > found working
> > > with a developer from Tundra.
> > That  is great. 
> > I will test your patch on 7448hpc2 board tomorrow and give 
> > the feedback.
> > Roy
> Patches were fine for 7448hpc2 board.

Excellent.  Thanks for testing that Roy.

> Patch 7/7 seems broken on current Paul's tree. I fixed it myself.

Depending on the definition of "current", all of these patches should
already be in Paul's tree :)

josh
