Return-Path: <kristen.c.accardi@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by ozlabs.org (Postfix) with ESMTP id AAE24DDEBA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 01:46:15 +1000 (EST)
Date: Thu, 5 Apr 2007 08:33:48 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-Id: <20070405083348.36c8e38b.kristen.c.accardi@intel.com>
In-Reply-To: <20070403163414.GN4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403163414.GN4922@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, gregkh@suse.de,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Apr 2007 11:34:14 -0500
linas@austin.ibm.com (Linas Vepstas) wrote:

> 
> Hi Kristen,
> 
> Please queue these cleanup patches for 2.6.22.

Ok - will do.

> 
> This is a collection of very small, mostly trite, patches that clean up 
> various bits and pieces of the RPAPHP hotplug code. They eliminate
> almost 10% of the code, while making almost no funcional change. 
> There are a few bugfixes to various error paths, and one memleak fix. 
> Some documentation is added.  The result is, I beleive, slightly more 
> readable, easier to understand code. In particular, the enable/disable 
> add/remove code paths are now more obviously symmetrical in thier function.
> 
> --linas
> 
> p.s. some more simplifcation is possible: one could probably merge
> __enable_slot() and rpaphp_enable_slot() with a bit of elbow grease,
> and the asymmetric pairing of rpaphp_deregister_slot()  with
> rpaphp_add_slot() as "opposites" of each other still bugs me.
> 
> I'm also irked that dlpar_pci_add_bus() is quite similar to 
> pcibios_add_pci_devices() which is quite similar to init_phb_dynamic()
> and think that these should be refactored so that they are more clearly
> orthogonal to one another. Just right now, I'm not planning on doing 
> anything about this, at least, not without prodding.
> 
> --linas 
> 

Thanks for the cleanups - most of the drivers in the hotplug tree badly
need cleaning up, but... 

Kristen
