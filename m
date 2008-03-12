Return-Path: <jens@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2F069DDF2D
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 09:30:43 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id m2CMUc4o333632
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 22:30:38 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m2CMUcx91994988
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 23:30:38 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m2CMUcDr005036
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 23:30:38 +0100
From: Jens Osterkamp <jens@de.ibm.com>
To: luisgpm@linux.vnet.ibm.com
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Wed, 12 Mar 2008 23:30:36 +0100
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
In-Reply-To: <1205344272.2272.45.camel@gargoyle>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803122330.36905.jens@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan Kratochvil <jan.kratochvil@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Just to make sure, i tested the binary against the 2.6.25-rc4 kernel. It
> still fails. So this is really an open bug for PPC.

On a Cell- or 970-based machine ?

Gruß,
	Jens

IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschäftsführung: Herbert Kircher 
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
