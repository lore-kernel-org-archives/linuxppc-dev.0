Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEDBFDDEC2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 May 2007 01:05:11 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hlniw-000443-9D
	for linuxppc-embedded@ozlabs.org; Wed, 09 May 2007 17:05:02 +0200
Received: from s01060016b61d1226.cg.shawcable.net ([68.147.67.118])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 09 May 2007 17:05:02 +0200
Received: from grant.likely by s01060016b61d1226.cg.shawcable.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 09 May 2007 17:05:02 +0200
To: linuxppc-embedded@ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Xilinx OPB EMC Linux 2.6 Driver
Date: Wed, 09 May 2007 08:32:01 -0600
Message-ID: <4641DB61.1020708@secretlab.ca>
References: <BAY115-W4C8C341511C29C64FA72AB23B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
In-Reply-To: <BAY115-W4C8C341511C29C64FA72AB23B0@phx.gbl>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Mohammad Sadegh Sadri wrote:
> But I think that some thing is missing here, There should be a driver to enable Extended Memory Controller (OPB EMC) module which is mainly connected to the strata flash chip. Is this true? Or the current drivers in the kernel are enough? 

The EMC core does not require any drivers.  It transparently maps 
external devices onto the OPB bus.

> 
> May be I should enable support for CFI and then I choose CFI in physical memory option?

Yes
