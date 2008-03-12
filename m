Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw1.br.ibm.com (igw1.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FAF0DDED1
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 04:51:28 +1100 (EST)
Received: from mailhub3.br.ibm.com (mailhub3 [9.18.232.110])
	by igw1.br.ibm.com (Postfix) with ESMTP id 1876E32C08C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 14:30:41 -0300 (BRST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2CHpIs24464652
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 14:51:18 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2CHpHfs000906
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 14:51:18 -0300
Subject: Re: PPC upstream kernel ignored DABR bug
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200803101501.34439.jens@de.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de> <1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 12 Mar 2008 14:51:12 -0300
Message-Id: <1205344272.2272.45.camel@gargoyle>
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

Hi,

> On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
> already did this. Uli Weigand found this back in November. I submitted
> a patch for this which went into 2.6.25-rc4.
> Can you please try again with rc4 ?

> Gruß,
> 
> Jens

Just to make sure, i tested the binary against the 2.6.25-rc4 kernel. It
still fails. So this is really an open bug for PPC.

-- 
Luis Machado
Software Engineer 
IBM Linux Technology Center
