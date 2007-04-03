Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8EFCBDDEDF
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 02:18:38 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l33GGO0p020798
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 12:16:24 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33GIZm5045122
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 10:18:35 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33GIYAO005853
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 10:18:35 -0600
Date: Tue, 3 Apr 2007 11:18:33 -0500
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/19]: RPAPHP pci hotplug cleanup patchbomb
Message-ID: <20070403161833.GM4922@austin.ibm.com>
References: <20070403002629.GI4922@austin.ibm.com>
	<20070403041558.GA30825@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070403041558.GA30825@suse.de>
From: linas@austin.ibm.com (Linas Vepstas)
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

On Mon, Apr 02, 2007 at 09:15:58PM -0700, Greg KH wrote:
> On Mon, Apr 02, 2007 at 07:26:29PM -0500, Linas Vepstas wrote:
> > 
> > Hi Greg, 
> > 
> > Please queue these cleanp patches for 2.6.22; cc'ing akpm.
> 
> Kristen is the PCI Hotplug maintainer now (been that way for a number of
> months).  Please cc: her on them so that she can review them, and if
> acceptable, she will forward them up the foodchain properly.
> 
> Also, you might want to CC: the linux pci hotplug list at the same time
> so others can review them.

Dohh. OK. However, I'll trim linux-pci@atrey.karlin.mff.cuni.cz from
the resend. Too much cross posting for silly patches such as these 
makes me uncomfortable.

--linas
