Return-Path: <wfarnsworth@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 1B3E667A46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:08:05 +1100 (EST)
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050315184153.GB28823@gate.ebshome.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<20050315184153.GB28823@gate.ebshome.net>
Content-Type: text/plain
Message-Id: <1110913681.24673.42.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 15 Mar 2005 12:08:01 -0700
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/3] PPC440EP SoC and Bamboo board support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2005-03-15 at 11:41, Eugene Surovegin wrote:

[snip]

> 
> > diff -uprN linux-2.6.11-bk7/include/asm-ppc/reg.h linux-2.6.11-bk7-440ep/include/asm-ppc/reg.h
> > --- linux-2.6.11-bk7/include/asm-ppc/reg.h	2005-03-11 16:25:22.000000000 -0700
> > +++ linux-2.6.11-bk7-440ep/include/asm-ppc/reg.h	2005-03-14 10:05:47.000000000 -0700
> > @@ -449,6 +449,8 @@
> >  #define PVR_STB03XXX	0x40310000
> >  #define PVR_NP405H	0x41410000
> >  #define PVR_NP405L	0x41610000
> > +#define PVR_440EP_RA	0x42221850
> > +#define PVR_440EP_RB	0x422218D3
> 
> 
> I don't think it's needed. There are plans to get rid of all not-used 
> PVR defines.

The PVR for the Rev A is needed for a workaround in the IBM EMAC code
(see patch 3/3).  If there is a better way to do this, or if it would be
better to put the PVR define somewhere else, please let me know.

Thanks for your comments.

Regards,
Wade Farnsworth
