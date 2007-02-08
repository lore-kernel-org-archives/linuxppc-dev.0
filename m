Return-Path: <Jens.Osterkamp@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31A29DDEC0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 23:56:58 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l18CurTY303212
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 12:56:53 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l18CurTr2080780
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 13:56:53 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l18CurTo019350
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Feb 2007 13:56:53 +0100
In-Reply-To: <1170894259.2620.325.camel@localhost.localdomain>
Subject: Re: [PATCH 0/4] spidernet: support for Celleb
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF4CD93CB2.C6D8AB5B-ONC125727C.0035FE0B-C125727C.00472022@de.ibm.com>
From: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Date: Thu, 8 Feb 2007 13:56:52 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> PHY patch is mostly Ok except I don't like that "medium" variable Jens
> added which isn't used anywhere in sungem_phy. Jens, can you resend a
> version without that ? If you need that variable in spidernet itself,
> then put it there :-)

That was the idea I had first, I'll change that.

> Also, the GMII_* constants, are they standard or 54xx specific ? If the
> later, then change the name to reflect that.

I'll check...

Jens
