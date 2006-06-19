Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2EF167B1D
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:07:05 +1000 (EST)
In-Reply-To: <E1FsSmY-0000Oz-P2@jdl.com>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
	<E1FsSmY-0000Oz-P2@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <72C71D61-F43A-4644-BBE8-F8B3B8526195@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Interrupt mapping documentation 
Date: Tue, 20 Jun 2006 01:07:00 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Just *require* #address-cells for everything with addressable sub- 
>> nodes,
>> at least in DTC.  Doesn't cost much, and no confusion anymore.
>
> Woot!  Send me a patch! :-)

Noooo...  tiiiime...  And way too lazy.

Could you pick this up, please?


Segher
