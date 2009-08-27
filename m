Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 89E63B7BA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 01:58:50 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C4116DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 01:58:48 +1000 (EST)
Message-ID: <4A96AD4B.1010204@freescale.com>
Date: Thu, 27 Aug 2009 10:59:07 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "wilbur.chan" <wilbur512@gmail.com>
Subject: Re: Can't write value into memory ?(E500 V2)
References: <e997b7420908260739u49fb4b36j9eb148782829547b@mail.gmail.com>	
	<20090826192030.GA17027@b07421-ec1.am.freescale.net>
	<e997b7420908270853i7d4058e1p8ddcfcf8df18486e@mail.gmail.com>
In-Reply-To: <e997b7420908270853i7d4058e1p8ddcfcf8df18486e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wilbur.chan wrote:
> I am using a SMP E500 v2, and I want CPU0 to write some value to a 
> physical address, and  wait for CPU1 to read from it.

Is this under Linux (it is a Linux mailing list...)?  If so, there are 
better ways of communicating that don't involve clobbering random memory 
and overlapping userspace TLB mappings.

> However, it seemed failed to communicate between CPUs by DRAM..  CPU1 
> can not read
>  
> the correct value from the address where CPU1 wrote to.

Do both cores have a mapping with the M bit (memory coherence required) set?

-Scott
