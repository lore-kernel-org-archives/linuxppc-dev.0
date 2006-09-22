Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5585767B9F
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Sep 2006 09:50:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8MNoJMv005362
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 19:50:19 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8MNoIpe215222
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 17:50:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8MNoIHu007003
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 17:50:18 -0600
Date: Fri, 22 Sep 2006 18:50:17 -0500
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20060922235017.GD14213@austin.ibm.com>
References: <20060921231314.GW29167@austin.ibm.com>
	<20060922220629.GA4600@dreamland.darkstar.lan>
	<20060922233235.GB14213@austin.ibm.com>
	<20060922163929.bb870ee1.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060922163929.bb870ee1.rdunlap@xenotime.net>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Luca <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 22, 2006 at 04:39:29PM -0700, Randy.Dunlap wrote:
> On Fri, 22 Sep 2006 18:32:35 -0500 Linas Vepstas wrote:
> 
> > On Sat, Sep 23, 2006 at 12:06:29AM +0200, Luca wrote:
> > > 
> > > Space after function name? You put in other places too, it's not
> > > consistent with the rest of the patch.
> > 
> > Oops. I was also coding on a different project recently, with a
> > different style.  I'll send a revised patch in a moment.
> 
> Please change if()'s to use
> 
> 	if (var == constant)
> instead of
> 	if (constant == var)

Yuck! Horrid coding style! No rational excuse for coding like that.
Advice taken under protest; new patch shortly.

--linas
