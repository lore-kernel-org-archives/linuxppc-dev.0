Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7EA80DDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 14:43:34 +1000 (EST)
Date: Mon, 2 Apr 2007 21:15:58 -0700
From: Greg KH <gregkh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070403041558.GA30825@suse.de>
References: <20070403002629.GI4922@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 02, 2007 at 07:26:29PM -0500, Linas Vepstas wrote:
> 
> Hi Greg, 
> 
> Please queue these cleanp patches for 2.6.22; cc'ing akpm.

Kristen is the PCI Hotplug maintainer now (been that way for a number of
months).  Please cc: her on them so that she can review them, and if
acceptable, she will forward them up the foodchain properly.

Also, you might want to CC: the linux pci hotplug list at the same time
so others can review them.

thanks,

greg k-h
