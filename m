Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56E7DDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 11:15:39 +1100 (EST)
Date: Thu, 20 Dec 2007 16:14:25 -0800
From: Greg KH <gregkh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: patch
	pci-fix-bus-resource-assignment-on-32-bits-with-64b-resources.patch
	added to gregkh-2.6 tree
Message-ID: <20071221001425.GB23322@suse.de>
References: <11981938363358@kroah.org> <1198194973.6779.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1198194973.6779.35.camel@pasglop>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 21, 2007 at 10:56:13AM +1100, Benjamin Herrenschmidt wrote:
> 
> > The current pci_assign_unassigned_resources() code doesn't work properly
> > on 32 bits platforms with 64 bits resources. The main reason is the use
> > of unsigned long in various places instead of resource_size_t.
> > 
> > This fixes it, along with some tricks to avoid casting to 64 bits on
> > platforms that don't need it in every printk around.
> 
> Can you still edit the changelog ?

Yes I can.

> If yes, please remove that sentence
> since the latest version (which you put in your tree) doesn't actually
> have those tricks anymore as per discussion on the list...

Ok, now done, thanks.

greg k-h
