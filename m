Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 0738567C5A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 15:29:56 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add FSL CPM2 device tree node documentation
From: Paul Nasrat <pnasrat@redhat.com>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
References: <20060328161431.18517.82573.stgit@vitb.ru.mvista.com>
	<1143564910.2660.4.camel@enki.eridu>
	<644FB6AC-3702-41D0-A9E2-6FDEC52B819D@freescale.com>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 01:14:56 -0400
Message-Id: <1144905296.29397.40.camel@enki.eridu>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Jon Loeliger <jdl@jdl.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-04-12 at 18:19 -0500, Andy Fleming wrote:
> On Mar 28, 2006, at 10:55, Paul Nasrat wrote:
> 
> > On Tue, 2006-03-28 at 20:14 +0400, Vitaly Bordug wrote:

> >> +	  - address : List of bytes representing the ethernet address of
> >> +		this controller
> >
> > Umm should we not use local-mac-address and mac-address (and
> > address-bits) as in section 3.7.4 in 1275-1994?
> 
> 
> So no one chimed in on this.  Clearly, 1275 states that it's supposed  
> to be local-mac-address or mac-address.  We use "address".  But I'm  
> pretty sure we copied our ethernet node from somewhere else, so which  
> one should it be?

Well I'm biased and say we shouldn't reinvent the wheel with dtc if we
don't need to.  I've sent Jon a patch to start validating this for dtc
and am waiting feedback before I add additional device_types. So we
should have local-mac-address be preassiged hwaddr and mac-address last
used. For some setups this would be the same persistently, but I can
envisage some non OF setups populating mac-address from the card. 

Paul
