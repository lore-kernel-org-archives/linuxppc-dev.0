Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5D63D67A3E
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 03:49:29 +1000 (EST)
Date: Mon, 31 Jul 2006 19:49:24 +0200
From: Olaf Hering <olh@suse.de>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] remove bogomips from /proc/cpuinfo
Message-ID: <20060731174924.GA4273@suse.de>
References: <20060731125904.GA1997@suse.de>
	<200607311946.18331.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200607311946.18331.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Jul 31, Arnd Bergmann wrote:

> On Monday 31 July 2006 14:59, Olaf Hering wrote:
> > Remove bogomips from /proc/cpuinfo.
> > It is now really bogus since "timebase-frequency" is shown.
> 
> Well, but it's still part of the ABI, right?
> How do you determine that there are no broken applications
> still relying on it?

Everything works on a G5, as example. Alpha doesnt have it either.
What pratical value had bogomips for an application?
