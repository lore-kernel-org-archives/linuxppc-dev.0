Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 556D0DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 10:12:41 +1100 (EST)
Date: Fri, 12 Jan 2007 15:11:46 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
Message-ID: <20070112231146.GB665@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
	<1168550403.22458.414.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168550403.22458.414.camel@localhost.localdomain>
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

On Fri, Jan 12, 2007 at 08:20:02AM +1100, Benjamin Herrenschmidt wrote:
> 
> > So, no, I don't agree with this implementation and don't want to see it
> > go through anyone's tree into mainline just yet.
> 
> So why, when we posted it earlier, you said the exact opposite ? That
> you actually liked it and wanted to see it as a replacement of the
> current cruft ?

Well, I didn't realize at that time that this was ppc only code.  I
missed the location of those function calls, assuming that no one would
put generic PCI calls down in a arch-specific tree only.

thanks,

greg k-h
