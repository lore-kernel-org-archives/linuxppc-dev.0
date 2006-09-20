Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDDA267A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 15:47:07 +1000 (EST)
In-Reply-To: <1158710938.6002.223.camel@localhost.localdomain>
References: <20060919222351.d27a1a06.sfr@canb.auug.org.au>
	<20060919182953.GK29167@austin.ibm.com>
	<1158707532.6002.171.camel@localhost.localdomain>
	<F3BB850E-E6DD-4CE1-A93B-A56BD2C4B653@kernel.crashing.org>
	<1158710938.6002.223.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9F465EDA-8678-47DF-B3BA-0A4134A45D05@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] convert string i/o operations to C
Date: Wed, 20 Sep 2006 02:29:59 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Why?  If "ns" <= 0 there is no I/O done...
>
> For the sake of being paranoid :) What happens on x86 if you do a  
> rep ;
> insw with a 0 count ?

Nothing, except wasting energy.


Segher
