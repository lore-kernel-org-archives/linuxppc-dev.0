Return-Path: <roland@redhat.com>
Received: from QMTA04.emeryville.ca.mail.comcast.net
	(qmta04.emeryville.ca.mail.comcast.net [76.96.30.40])
	by ozlabs.org (Postfix) with ESMTP id E96CFDDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 07:00:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: PPC upstream kernel ignored DABR bug
In-Reply-To: Olof Johansson's message of  Monday,
	10 March 2008 14:50:57 -0500 <20080310195057.GA28140@lixom.net>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de>
	<1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
	<20080310191957.0B42626F991@magilla.localdomain>
	<1205177797.23926.21.camel@gargoyle.br.ibm.com>
	<20080310195057.GA28140@lixom.net>
Message-Id: <20080310195408.868DF26F991@magilla.localdomain>
Date: Mon, 10 Mar 2008 12:54:08 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jan Kratochvil <jan.kratochvil@redhat.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The G5 that I have says:

	cpu             : PPC970FX, altivec supported
	revision        : 3.0 (pvr 003c 0300)

and it does indeed reproduce this bug.

It also strange for it to be the DABRX issue given the failure mode.
That is, it works sometimes but unreliably (as if the context switch
sometimes fails to install the value).


Thanks,
Roland
