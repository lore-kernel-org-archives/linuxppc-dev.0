Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw2.br.ibm.com (igw2.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw2.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1395FDDF1E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 00:13:58 +1100 (EST)
Received: from mailhub1.br.ibm.com (mailhub1 [9.18.232.109])
	by igw2.br.ibm.com (Postfix) with ESMTP id 0127B17F649
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:05:42 -0300 (BRST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2DDDn9u3747900
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:13:49 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2DDDnvM017429
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 10:13:49 -0300
Subject: Re: PPC upstream kernel ignored DABR bug
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Jens Osterkamp <jens@de.ibm.com>
In-Reply-To: <200803122330.36905.jens@de.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Date: Thu, 13 Mar 2008 10:13:41 -0300
Message-Id: <1205414021.16531.0.camel@gargoyle>
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

On Wed, 2008-03-12 at 23:30 +0100, Jens Osterkamp wrote:
> > Just to make sure, i tested the binary against the 2.6.25-rc4 kernel. It
> > still fails. So this is really an open bug for PPC.
> 
> On a Cell- or 970-based machine ?
> 
> Gruß,
> 	Jens

On a 970-based machine.

Regards,

-- 
Luis Machado
Software Engineer 
IBM Linux Technology Center
