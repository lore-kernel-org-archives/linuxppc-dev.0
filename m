Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BAE13DE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 04:21:00 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0BHKuMr031141
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:20:56 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	l0BHJlUH255896
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:19:47 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l0BHJktJ001167
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 12:19:47 -0500
Subject: Re: [PATCH 4/7] MPIC MSI allocator
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <265e85080dc6d43eed2a42d06412eb92@kernel.crashing.org>
References: <20070111112504.37999DDF3E@ozlabs.org>
	<265e85080dc6d43eed2a42d06412eb92@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 11:19:41 -0600
Message-Id: <1168535981.18021.50.camel@localhost>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof Johannsson <olof@lixom.net>,
	linux-pci@atrey.karlin.mff.cuni.cz
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-11-01 at 16:14 +0100, Segher Boessenkool wrote:
> > +	msi_debug("found U3, guessing msi allocator setup\n");
> > +
> > +	/* Reserve source numbers we know are reserved in the HW */
> > +	for (i = 0;   i < 8;   i++) __mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i = 42;  i < 46;  i++) __mpic_msi_reserve_hwirq(mpic, i);
> > +	for (i = 100; i < 105; i++) __mpic_msi_reserve_hwirq(mpic, i);
> 
> Coding style.  The ranges you reserve are a bit too wide,
> but that is certainly safe.

Can you clarify that comment a bit for me?    Why are they too wide, and
if they are too wide, how are they still safe?   

-Will

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
