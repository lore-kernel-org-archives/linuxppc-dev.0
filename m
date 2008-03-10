Return-Path: <jens@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03EDCDDEF9
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 01:01:44 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id m2AE1eRa207210
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 14:01:40 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m2AE1d0j2056236
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 15:01:39 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m2AE1Zli020423
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 15:01:38 +0100
From: Jens Osterkamp <jens@de.ibm.com>
To: linuxppc-dev@ozlabs.org, luisgpm@linux.vnet.ibm.com
Subject: Re: PPC upstream kernel ignored DABR bug
Date: Mon, 10 Mar 2008 15:01:34 +0100
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de>
	<1205110432.10078.5.camel@gargoyle>
In-Reply-To: <1205110432.10078.5.camel@gargoyle>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803101501.34439.jens@de.ibm.com>
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Roland McGrath <roland@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 10 March 2008, Luis Machado wrote:
> > Yes, I know. I tried it on the PS3 first and couldn't reproduce
> > the bug he saw on the blade.
> 
> Arnd,
> 
> Do we have any news on this topic? 
> 
> I've seen this happening quite often within GDB when using hardware
> watchpoints on a shared variable in a threaded (7+ threads) binary.
> Sometimes the watchpoint won't trigger, even though the monitored
> variable's value was modified.

On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
already did this. Uli Weigand found this back in November. I submitted
a patch for this which went into 2.6.25-rc4.
Can you please try again with rc4 ?

Gruß,

Jens

IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Geschäftsführung: Herbert Kircher 
Sitz der Gesellschaft: Böblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
