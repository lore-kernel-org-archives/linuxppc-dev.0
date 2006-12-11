Return-Path: <krafft@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49A8967CA1
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 04:24:02 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kBBHNsuR074528
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:23:54 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBBHNslr1683662
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:23:54 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBBHNrML014402
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 17:23:54 GMT
Date: Mon, 11 Dec 2006 18:20:01 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Message-ID: <20061211182001.0896b7bd@localhost>
In-Reply-To: <06260804-0C3C-4A40-9E69-408E77973984@kernel.crashing.org>
References: <20061207172259.64168f8c@localhost>
	<89216897-DF66-4C4E-9436-BD7816424139@schihei.de>
	<1F172C93-90F5-48E5-88D7-4D0BC0E1841A@kernel.crashing.org>
	<200612111525.50044.arnd@arndb.de>
	<2C6AF45B-CD26-449B-B12C-1A89D8537463@schihei.de>
	<06260804-0C3C-4A40-9E69-408E77973984@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Good then, it make things easier for me ;-)
Will send an updated version soon...

Cheers, ck

On Mon, 11 Dec 2006 17:58:36 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > If I understood you comments an example OFDT node for IPMI could
> > look like the following:
> >
> > name =3D "ipmi"
> > device_type =3D "ipmi"
> > compatible =3D "ipmi-kcs"
> >
> > reg =3D XXXXXXX8 00000008
> > reg-spacing =3D 4
>=20
> Yeah.
>=20
> > reg-size    =3D 1
> > reg-shift   =3D 0
>=20
> But without these two, they are the default.
>=20
> > Is the "8" of the reg property correct?
>=20
> Sure.  Alternatively, if your device really only claims
> bus cycles targeting the 8-bit regs at xxx8 and xxxC, you
> can say that in the "reg" property.  This doesn't change
> the programming model in the least though.
>=20
> > I'm still worried what happens when we have a BT or SMIC interface
> > an the registers sitting at XXXXXXX4, XXXXXXX6, XXXXXXXA. In this
> > case the reg-spacing property can't be used anymore. Can this
> > happen in reality?
>=20
> I don't think it is allowed.  Either way, the generic Linux IPMI
> code would need changing for this -- let's worry about it later
> (if ever!)
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
