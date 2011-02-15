Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AB3D9B711C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Feb 2011 12:08:34 +1100 (EST)
Date: Mon, 14 Feb 2011 17:04:16 -0800
From: Greg KH <greg@kroah.com>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V8 03/10] USB/ppc4xx: Add Synopsys DWC OTG Core
	InterfaceLayer
Message-ID: <20110215010416.GA16060@kroah.com>
References: <4f99d54a42d4f13663c88b0b081f047b@mail.gmail.com>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AC4D@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AC4D@saturn3.aculab.com>
Cc: Tirumala Marri <tmarri@apm.com>, linux-usb@vger.kernel.org,
	Alexander Gordeev <lasaine@lvk.cs.msu.su>,
	Mark Miesfeld <mmiesfeld@apm.com>, linuxppc-dev@lists.ozlabs.org,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 08:53:21AM -0000, David Laight wrote:
>  
> > > Sorry, I don't understand that. I think u32 is always 32bit 
> > > 4byte on all archs. Right?
> > 
> > Yes.
> > 
> > Use an unsigned long if you want to hold a pointer correctly on all
> > arches.
> 
> Although that is true for many systems (and probably all ppc Linux)
> it isn't necessarily true (eg 64 bit Microsoft Windows).

Again, it is true for all Linux architectures.  We aren't caring about
any other operating systems here, sorry.

> C99 inttypes.h should define uintptr_t as an unsigned integer
> type that is large enough to hold a (data) pointer.
> I'm not sure if this is defined for the Linux kernel.

uint* aren't to be used within the kernel as they make no sense.

thanks,

greg k-h
