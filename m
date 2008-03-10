Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw2.br.ibm.com (igw2.br.ibm.com [32.104.18.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mailgw2.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17B6DDE21D
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 06:36:57 +1100 (EST)
Received: from mailhub3.br.ibm.com (mailhub3 [9.18.232.110])
	by igw2.br.ibm.com (Postfix) with ESMTP id 1DE5F17F4E3
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 16:28:46 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub3.br.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2AJaimk3870768
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 16:36:48 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2AJagKT001752
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Mar 2008 16:36:42 -0300
Subject: Re: PPC upstream kernel ignored DABR bug
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080310191957.0B42626F991@magilla.localdomain>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de> <1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
	<20080310191957.0B42626F991@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 10 Mar 2008 16:36:37 -0300
Message-Id: <1205177797.23926.21.camel@gargoyle.br.ibm.com>
Mime-Version: 1.0
Cc: Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-10 at 12:19 -0700, Roland McGrath wrote:
> > On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
> > already did this. Uli Weigand found this back in November. I submitted
> > a patch for this which went into 2.6.25-rc4.
> > Can you please try again with rc4 ?
> 
> This is not the problem.  This came up before and everyone seems have
> forgotten.  This bug has been reproduced on G5's, which do not have DABRX
> as I understand it.

Yes, now that you mentioned, i've been able to reproduce this on 970FX's
blades, which i don't think have DABRX registers. I guess it's the
almost the same CPU as G5's.

Regards,

-- 
Luis Machado
Software Engineer 
IBM Linux Technology Center
