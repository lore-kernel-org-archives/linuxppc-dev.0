Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0BB45DDEB7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 12:57:37 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l772vWUW011135
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 19:57:32 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l772vU53004606
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 21:57:31 -0500 (CDT)
Subject: Re: Please pull powerpc.git merge branch
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: michael@ellerman.id.au
In-Reply-To: <1186448777.19257.0.camel@concordia.ozlabs.ibm.com>
References: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
	<FCAE5E05-7F25-436F-963B-B757765D343A@kernel.crashing.org>
	<1186448777.19257.0.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1186455451.2163.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 07 Aug 2007 10:57:31 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-08-07 at 09:06, Michael Ellerman wrote:
> On Mon, 2007-08-06 at 08:57 -0500, Kumar Gala wrote:
> > On Aug 6, 2007, at 12:57 AM, Zhang Wei-r63237 wrote:
> > 
> > > Hi, Paul,
> > >
> > > How about following patches?
> > >
> > > [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC
> architecture  
> > > with
> > > ULI chip quirk functions.
> > > URL:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040363.html
> > > [PATCH 2/2] Remove ULI chip quirks functions from MPC8641HPCN and
> > > MPC8544DS boards.
> > > URL:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040364.html
> > >
> > > [PATCH 1/3] Add a new member name to structure irq_host
> > > URL:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039896.html
> > > [PATCH 2/3] Add irq host name for all powerpc interrupt
> controllors.
> > > URL:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039897.html
> > > [PATCH 3/3] Add irq debugfs and virq_mapping for getting the virq
> > > URL:
> http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039895.html
> > 
> > These patches aren't fixing any bugs and would be for 2.6.24 at
> this  
> > point.
> 
> And I reworked them and posted new versions.
Where are the new versions?
I missed them?
Roy
