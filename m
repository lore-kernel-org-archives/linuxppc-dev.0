Return-Path: <krafft@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BB18DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 00:16:59 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kBJDGptr089298
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 13:16:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBJDGpql1372368
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 13:16:51 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBJDGoSE009444
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 13:16:50 GMT
Date: Tue, 19 Dec 2006 14:12:45 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
Message-ID: <20061219141245.679caa11@localhost>
In-Reply-To: <A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Christian Krafft <krafft@linux.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Dec 2006 22:52:07 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:


>=20
> info->io_regsize =3D regsize ? *regsize : DEFAULT_REGSIZE;
>=20
> [Please note that fixes a copy/paste bug, too].

There is no DEFAULT_REGSIZE, all the code is using DEFAULT_REGSPACING as th=
e default size.
It looks like the code assumes that the registers are located next to each =
other.
If thats not good, DEFAULT_REGSIZE should be introduced and used in all oth=
er probe functions as well.
That would be a seperate issue .

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
