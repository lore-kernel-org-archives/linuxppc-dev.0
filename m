Return-Path: <rpjday@mindspring.com>
Received: from rubicon.netdirect.ca (nic.NetDirect.CA [216.16.235.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E8F5DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:18:59 +1000 (EST)
Date: Tue, 17 Jul 2007 18:17:01 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] POWERPC:  Correct misspelled config variable in
	arch/powerpc/Kconfig.
In-Reply-To: <18076.46827.932735.590316@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0707171816420.21158@localhost.localdomain>
References: <Pine.LNX.4.64.0707141820150.9894@localhost.localdomain>
	<18076.46827.932735.590316@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jul 2007, Paul Mackerras wrote:

> Robert P. J. Day writes:
>
> > -config CONFIG_CHECK_CACHE_COHERENCY
> > +config CHECK_CACHE_COHERENCY
>
> Please also fix the occurrence in
> arch/powerpc/platforms/embedded6xx/Kconfig.

ah, i completely missed that one.  i'll resubmit the patch shortly.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
