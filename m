Return-Path: <maxim@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2A85DE15C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 21:00:21 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m69AwRJs365890
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 10:58:27 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m69AwRc12080948
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:58:27 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m69AwQ68012987
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jul 2008 11:58:27 +0100
Date: Wed, 9 Jul 2008 12:58:48 +0200
From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
To: linux-fsdevel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: AZFS file system proposal
Message-ID: <20080709125848.643008a3@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <1215595414.8970.366.camel@pasglop>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<1215593918.8970.363.camel@pasglop>
	<20080709111402.5af92580@mercedes-benz.boeblingen.de.ibm.com>
	<1215595414.8970.366.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'd rather do
>=20
> 	pgprot_t  prot;
>=20
> #ifdef CONFIG_PPC
> 	prot =3D <whatever>
> #else
> 	prot =3D pgprot_noncached(...)
> #endif
> 	vma->vm_page_prot =3D prot;

I have changed my patch accordinly. Thank you.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / met vriendelijke groeten / avec regards

    Maxim V. Shchetynin
    Linux Kernel Entwicklung
    IBM Deutschland Research & Development GmbH
    Linux f=C3=BCr Cell, Abteilung 3250
    Sch=C3=B6naicher Stra=C3=9Fe 220
    71032 B=C3=B6blingen

Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch=C3=A4ftsf=C3=BChrung: Herbert Kircher
Sitz der Gesellschaft: B=C3=B6blingen
Registriergericht: Amtsgericht Stuttgart, HRB 243294

Fahr nur so schnell wie dein Schutzengel fliegen kann!
