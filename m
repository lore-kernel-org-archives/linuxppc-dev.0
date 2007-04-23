Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F30A8DDEFB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 04:30:35 +1000 (EST)
In-Reply-To: <20070423174339.20308ac3.sfr@canb.auug.org.au>
References: <20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<1176357020.8061.123.camel@localhost.localdomain>
	<20070411.232545.45203999.davem@davemloft.net>
	<17cfcd2e089f7154354fe6c4c1cadf3c@kernel.crashing.org>
	<20070423174339.20308ac3.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <23772b4d399b331b25459fc3c0f56fd4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start split out of common open firmware code
Date: Mon, 23 Apr 2007 20:30:29 +0200
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: paulus@samba.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> drivers/ is the wrong place to put this IMHO.  Why not
>> use kernel/openfirmware/*.[ch] ?
>
> We have drivers/acpi as a precedent ...

That doesn't mean it's a good place for firmware interface
code, it just means that the ACPI code currently lives
there :-)


Segher
