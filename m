Return-Path: <imp@bsdimp.com>
Received: from harmony.bsdimp.com (bsdimp.com [199.45.160.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D8E1DE149
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Aug 2008 00:43:59 +1000 (EST)
Date: Tue, 05 Aug 2008 08:41:03 -0600 (MDT)
Message-Id: <20080805.084103.74673921.imp@bsdimp.com>
To: marco.stornelli@coritel.it
Subject: Re: Quick question about dts
From: Warner Losh <imp@bsdimp.com>
In-Reply-To: <489802B3.805@coritel.it>
References: <20080805.005649.1713918190.imp@bsdimp.com>
	<489802B3.805@coritel.it>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Quick question about dts
Date: Tue, 05 Aug 2008 09:35:15 +0200

> M. Warner Losh ha scritto:
> > I have a .dts file that works with 2.6.18 (MV Pro 5.0).  I encode it
> > directly into the kernel image.  However, when I try to use it with my
> > 2.6.23, 2.6.24 or 2.6.25 kernel trees, it doesn't work at all.  In the
> > MV Pro 5.0 kernel, I hacked the startup sequence to store a pointer to
> > this blob in r3 so that it is moved in.  I've done something similar
> > in -current (for reasons that are too complicated to really explain
> > well, we can't do this via the normal boot loader mechanisms).  The
> > dtc complains that the interrupt-controller property is obsolete on
> > the chosen device.
> > 
> > Does any documentation exist for how dts has evolved?  I'd like to
> > forward port what I have without examining the .dts files from both
> > versions and guessing...
> > 
> > Warner
> > 
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> > 
> 
> Check out the kernel documentation booting-without-of.txt of your version.

Thanks.  I've already read this for both versions of the kernel.  It
doesn't tell me how dts has evolved.  It just tells me, mostly, what
is current for each version.

I've poked a little at the diffs between different versions.  But
these diffs are only what, not why.

Warner
