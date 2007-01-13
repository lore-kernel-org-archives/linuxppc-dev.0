Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC548DDE42
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 06:28:27 +1100 (EST)
Date: Sat, 13 Jan 2007 11:27:34 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
Message-ID: <20070113192734.GA30867@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
	<1168550403.22458.414.camel@localhost.localdomain>
	<1168552498.22458.428.camel@localhost.localdomain>
	<20070112231317.GC665@kroah.com>
	<1168667863.5011.44.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168667863.5011.44.camel@localhost.localdomain>
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

On Sat, Jan 13, 2007 at 04:57:43PM +1100, Benjamin Herrenschmidt wrote:
> 
> > No, what's wrong with just fixing everything up to work properly all at
> > once?  The Altix code should have been a step forward in making this
> > "abstracted" into something that other arches could use.  If that's not
> > true, then please work everything so that it all works nicely together.
> >
> > In short, I don't want to see two different implementations in the tree
> > at the same time, that's not acceptable, sorry.
> 
> So you are saying that despite the current stuff being beyond repair, we
> can't provide an alternate working implementation that fits our needs
> unless we also port over Altic and Intel, which we don't know and don't
> have testing gear, not even within our arch code ?

I'm saying I don't want to see 2 different MSI implementations in the
kernel.  I'm sure you can understand this reasoning.

I misunderstood your original patches in that I thought you were
cleaning up the generic versions for everyone, not creating a separate
set of APIs.  Sorry for the misunderstanding.

thanks,

greg k-h
