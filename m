Return-Path: <roland@redhat.com>
Received: from QMTA01.westchester.pa.mail.comcast.net
	(qmta01.westchester.pa.mail.comcast.net [76.96.62.16])
	by ozlabs.org (Postfix) with ESMTP id 38572DE278
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 06:26:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Jens Osterkamp <jens@de.ibm.com>
Subject: Re: PPC upstream kernel ignored DABR bug
In-Reply-To: Jens Osterkamp's message of  Monday,
	10 March 2008 15:01:34 +0100 <200803101501.34439.jens@de.ibm.com>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de>
	<1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
Message-Id: <20080310191957.0B42626F991@magilla.localdomain>
Date: Mon, 10 Mar 2008 12:19:57 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Jan Kratochvil <jan.kratochvil@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
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

This is not the problem.  This came up before and everyone seems have
forgotten.  This bug has been reproduced on G5's, which do not have DABRX
as I understand it.


Thanks,
Roland
