Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D7005DDF95
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 06:44:49 +1100 (EST)
Date: Mon, 10 Mar 2008 14:50:57 -0500
From: Olof Johansson <olof@lixom.net>
To: Luis Machado <luisgpm@linux.vnet.ibm.com>
Subject: Re: PPC upstream kernel ignored DABR bug
Message-ID: <20080310195057.GA28140@lixom.net>
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711290113.29024.arnd@arndb.de>
	<1205110432.10078.5.camel@gargoyle>
	<200803101501.34439.jens@de.ibm.com>
	<20080310191957.0B42626F991@magilla.localdomain>
	<1205177797.23926.21.camel@gargoyle.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1205177797.23926.21.camel@gargoyle.br.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Jan Kratochvil <jan.kratochvil@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Roland McGrath <roland@redhat.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 10, 2008 at 04:36:37PM -0300, Luis Machado wrote:
> On Mon, 2008-03-10 at 12:19 -0700, Roland McGrath wrote:
> > > On the Blade DABRX had to be set additional to DABR. PS3 and Celleb
> > > already did this. Uli Weigand found this back in November. I submitted
> > > a patch for this which went into 2.6.25-rc4.
> > > Can you please try again with rc4 ?
> > 
> > This is not the problem.  This came up before and everyone seems have
> > forgotten.  This bug has been reproduced on G5's, which do not have DABRX
> > as I understand it.
> 
> Yes, now that you mentioned, i've been able to reproduce this on 970FX's
> blades, which i don't think have DABRX registers. I guess it's the
> almost the same CPU as G5's.

What Apple called G5 were during the production runs three different
CPUs:

970
970FX
970MP

970 was only used in the very first models. 970MP was used in the last
(the models with pci-express and up to 4 cpus). 970FX was used on almost
everything else inbetween.


-Olof
