Return-Path: <krafft@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7A32DE093
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 11:44:52 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0P0il2D096878
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:44:47 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0P0ilI31876170
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:44:47 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0P0ikJg005946
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:44:47 GMT
Date: Thu, 25 Jan 2007 11:45:15 +1100
From: Christian Krafft <krafft@de.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Message-ID: <20070125114515.3ad78162@localhost>
In-Reply-To: <523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
	<1169682996.24996.11.camel@localhost.localdomain>
	<523FF36A-46DF-40CA-BFFE-EDE95EFA3EFE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, krafft@de.ibm.com,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I just recognized, that the forward declaration is in the tree, so I'll sen=
d an updated version with the cleanup call.

Tschuss,
ck

On Thu, 25 Jan 2007 01:29:48 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> >> +static int __devexit ipmi_of_remove(struct of_device *dev)
> >> +{
> >> +	/* should call
> >> +	 * cleanup_one_si(dev->dev.driver_data); */
> >> +	return 0;
> >> +}
> >
> > If your remove doesn't work, don't implement one.
>=20
> As explained before, it's the underlying thing that doesn't
> work.  Yeah someone should fix it one day.  Still it's better
> to have this comment than to not have anything at all.  An
> XXX FIXME: tag wouldn't be out of place of course.
>=20
> > Though since you don't
> > have the choice in having a module_exit or not, you should really
> > implement one that works :-)
>=20
> Genau.
>=20
>=20
> Segher
>=20


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
