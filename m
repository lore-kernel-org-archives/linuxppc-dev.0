Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A35BDDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 16:57:53 +1100 (EST)
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20070112231317.GC665@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
	<1168550403.22458.414.camel@localhost.localdomain>
	<1168552498.22458.428.camel@localhost.localdomain>
	<20070112231317.GC665@kroah.com>
Content-Type: text/plain
Date: Sat, 13 Jan 2007 16:57:43 +1100
Message-Id: <1168667863.5011.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> No, what's wrong with just fixing everything up to work properly all at
> once?  The Altix code should have been a step forward in making this
> "abstracted" into something that other arches could use.  If that's not
> true, then please work everything so that it all works nicely together.
>
> In short, I don't want to see two different implementations in the tree
> at the same time, that's not acceptable, sorry.

So you are saying that despite the current stuff being beyond repair, we
can't provide an alternate working implementation that fits our needs
unless we also port over Altic and Intel, which we don't know and don't
have testing gear, not even within our arch code ?

So you are trying to make sure PowerPC doesn't get MSI support until
next year or what ?

Ben.
