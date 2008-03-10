Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06EF6DDF3D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 02:14:17 +1100 (EST)
Received: from mailhub1.br.ibm.com (unknown [9.18.232.109])
	by igw3.br.ibm.com (Postfix) with ESMTP id 76C24390491
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 12:02:42 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2AFDfuV2314294
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 12:13:44 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2AFDbBh020718
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 12:13:38 -0300
Subject: Re: PPC upstream kernel ignored DABR bug
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200803101501.34439.jens@de.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de> <1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 12:13:32 -0300
Message-Id: <1205162012.23926.12.camel@gargoyle>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jan Kratochvil <jan.kratochvil@redhat.com>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
> already did this. Uli Weigand found this back in November. I submitted
> a patch for this which went into 2.6.25-rc4.
> Can you please try again with rc4 ?

I will try it and will post the results back.

Thanks Jens.

Regards,
-- 
Luis Machado
Software Engineer 
IBM Linux Technology Center
