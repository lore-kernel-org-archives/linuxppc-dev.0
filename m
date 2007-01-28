Return-Path: <krafft@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45EB7DE158
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 10:07:19 +1100 (EST)
Date: Mon, 29 Jan 2007 10:07:31 +1100
From: Christian Krafft <krafft@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Message-ID: <20070129100731.0c55e3c8@localhost>
In-Reply-To: <200701260523.04229.arnd@arndb.de>
References: <20061218163846.337fed65@localhost>
	<20070125104540.65a1f557@localhost> <20070126025431.GC18537@lst.de>
	<200701260523.04229.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian@ozlabs.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 26 Jan 2007 05:23:02 +0100
Arnd Bergmann <arnd@arndb.de> wrote:


> > > +static int __devexit ipmi_of_remove(struct of_device *dev)
> > > +{
> > > +=A0=A0=A0=A0=A0/* should call
> > > +=A0=A0=A0=A0=A0 * cleanup_one_si(dev->dev.driver_data); */
> >=20
> > Wo why doesn't it do that currently?=20

This has been fixed already by the updated version sent on 25/01/07, 14:34 =
EST.

--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
