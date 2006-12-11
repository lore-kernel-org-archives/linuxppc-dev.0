Return-Path: <krafft@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A02BA679FD
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 23:17:50 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id kBBCHjXJ164984
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 12:17:45 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBBCHjg32531542
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 13:17:45 +0100
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBBCHiHK002987
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 13:17:44 +0100
Date: Mon, 11 Dec 2006 13:13:54 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Message-ID: <20061211131354.5222c8ca@localhost>
In-Reply-To: <45799EBC.5060003@acm.org>
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost> <45799EBC.5060003@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

sorry and thanks,
I'll send an updated version with the comments about regsize worked in.


On Fri, 08 Dec 2006 11:19:56 -0600
Corey Minyard <minyard@acm.org> wrote:

> Ok, patch is in my tree with some minor changes required due to other
> changes that have gone in since 2.6.19.
>=20
> Christian Krafft wrote:
> > +};
> > +
> > +static void __devinit of_find_bmc(void)
> > +{
> > +	of_register_platform_driver(&ipmi_of_platform_driver);
> > +}
> > +#endif /* CONFIG_PM_OF */
> >
> I took the liberty of changing this to "CONFIG_PPC_OF"
>=20


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
