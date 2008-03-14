Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id E392ADDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 18:45:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PPC upstream kernel ignored DABR bug
In-Reply-To: Segher Boessenkool's message of  Friday,
	14 March 2008 03:11:12 +0100
	<7d9961563967d5f810a5f597519a7c63@kernel.crashing.org>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200803101501.34439.jens@de.ibm.com>
	<1205344272.2272.45.camel@gargoyle>
	<200803122330.36905.jens@de.ibm.com>
	<20080313014745.DE97826F992@magilla.localdomain>
	<2f8f82fe943fcd5103ec4cc39cc1bb26@kernel.crashing.org>
	<20080313224234.0A4FB26F993@magilla.localdomain>
	<7d9961563967d5f810a5f597519a7c63@kernel.crashing.org>
Message-Id: <20080314074547.BC48926F995@magilla.localdomain>
Date: Fri, 14 Mar 2008 00:45:47 -0700 (PDT)
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

> In both these cases, the storage access goes to LSU0, so you're
> not hitting the errata.

I'll take your word for it.

> If this doesn't help, and the failures stay intermittent, I don't think
> there is a close-to-the-hardware problem here.

I saw no effect from that change.  So now we're back to pure mystery, I guess.


Thanks,
Roland
