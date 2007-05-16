Return-Path: <greg@kroah.com>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3824EDDF07
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 17:20:32 +1000 (EST)
Date: Wed, 16 May 2007 00:15:48 -0700
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [viro@ftp.linux.org.uk: [PATCH] rpadlpar breakage - fallout of
	struct subsystem removal]
Message-ID: <20070516071548.GA19294@kroah.com>
References: <20070515194729.GE4095@ftp.linux.org.uk>
	<1179276588.4120.22.camel@concordia.ozlabs.ibm.com>
	<1179298629.32247.214.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1179298629.32247.214.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 16, 2007 at 04:57:09PM +1000, Benjamin Herrenschmidt wrote:
> 
> > That seems to work, I get 'add_slot' and 'remove_slot'
> > under /sys/bus/pci/slots/control again.
> 
> I verified that PCI hotplug actually works with that patch.

Thanks for testing, and Al, thanks for the patch, the rpadlpar code was
doing something different from what I expected...

thanks,

greg k-h
