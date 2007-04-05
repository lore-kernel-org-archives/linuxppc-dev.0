Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 764D6DDDEB
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Apr 2007 08:42:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l35MghQn025818
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 18:42:43 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l35Mfw5c315194
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 18:41:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l35MfvN2019867
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Apr 2007 18:41:58 -0400
Date: Thu, 5 Apr 2007 17:41:26 -0500
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070405224126.GC4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403163414.GN4922@austin.ibm.com>
	<20070405083348.36c8e38b.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070405083348.36c8e38b.kristen.c.accardi@intel.com>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Thu, Apr 05, 2007 at 08:33:48AM -0700, Kristen Carlson Accardi wrote:
> On Tue, 3 Apr 2007 11:34:14 -0500
> linas@austin.ibm.com (Linas Vepstas) wrote:
> 
> > Please queue these cleanup patches for 2.6.22.
> 
> Ok - will do.

Thanks,

> Thanks for the cleanups - 

I needed to do that to isolate a bug in some older distro kernels.

> most of the drivers in the hotplug tree badly
> need cleaning up, but... 

Hmm. Trying to get me to volunteer? I have no hardware to test 
any of the others.

--linas
