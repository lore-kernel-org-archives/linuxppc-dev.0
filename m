Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE0506810B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 14:51:13 +1000 (EST)
Date: Thu, 25 Aug 2005 06:51:08 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050825045108.GA19792@suse.de>
References: <20050824115452.GA29148@suse.de> <1124922771.5159.134.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1124922771.5159.134.camel@gaston>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: AC Power handling broken for desktops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Thu, Aug 25, Benjamin Herrenschmidt wrote:

> On Wed, 2005-08-24 at 13:54 +0200, Olaf Hering wrote:
> > My G4/450 runs without AC Power, according to /proc/pmu/info:
> > 
> > PMU driver version     : 2
> > PMU firmware version   : 0c
> > AC Power               : 0
> > Battery count          : 0
> > 
> > It should report 1. Where is the best place to get the
> > PMU_PWR_AC_PRESENT into ac_line_status?
> 
> Do we get the bit set from the PMU ? If not, maybe we should hard code
> that value on non-laptops

Appearently not, how do I check it?
