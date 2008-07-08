Return-Path: <maxim@linux.vnet.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 16C4BDDDDB
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 19:11:29 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m689AgWj094508
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 09:10:43 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m689Ag4W1233030
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 10:10:42 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m689Ag5u001257
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 10:10:42 +0100
Date: Tue, 8 Jul 2008 11:10:58 +0200
From: Maxim Shchetynin <maxim@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: Re: azfs: initial submit of azfs, a non-buffered filesystem
Message-ID: <20080708111058.6ca7e728@mercedes-benz.boeblingen.de.ibm.com>
In-Reply-To: <200807072137.45094.u.luckas@road.de>
References: <20080618160629.6cd749a8@mercedes-benz.boeblingen.de.ibm.com>
	<200807011659.33413.arnd@arndb.de>
	<20080707174230.63bc68cf@mercedes-benz.boeblingen.de.ibm.com>
	<200807072137.45094.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Uli Luckas <u.luckas@road.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Mon, 7 Jul 2008 21:37:43 +0200
schrieb Uli Luckas <u.luckas@road.de>:

> > AZFS is a file system which keeps all files on memory mapped random
> > access storage.
> Hi Maxim,=20
> do you mean "memory backed" instead of "memory mapped"?

Right, I have corrected this already in my patch.
Thank you.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / met vriendelijke groeten / avec regards

    Maxim V. Shchetynin
    Linux Kernel Entwicklung
    IBM Deutschland Entwicklung GmbH
    Linux f=C3=BCr Cell, Abteilung 3250
    Sch=C3=B6naicher Stra=C3=9Fe 220
    71032 B=C3=B6blingen

Vorsitzender des Aufsichtsrats: Johann Weihen
Gesch=C3=A4ftsf=C3=BChrung: Herbert Kircher
Sitz der Gesellschaft: B=C3=B6blingen
Registriergericht: Amtsgericht Stuttgart, HRB 243294

Fahr nur so schnell wie dein Schutzengel fliegen kann!
