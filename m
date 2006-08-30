Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CF45767B62
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 01:05:55 +1000 (EST)
Message-ID: <44F5A92D.6070902@am.sony.com>
Date: Wed, 30 Aug 2006 08:05:17 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: undefined reference to pci_io_base
References: <44F47ABE.7080602@am.sony.com>	<17652.49904.419167.448821@cargo.ozlabs.ibm.com>	<20060829232026.GC27372@austin.ibm.com>	<44F4D458.7030707@am.sony.com>
	<17652.55334.554969.284398@cargo.ozlabs.ibm.com>
In-Reply-To: <17652.55334.554969.284398@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> I found the same, but was thinking
>> 
>> #if defined(CONFIG_ISA) && !defined(__mc68000__)
>> 
>> So it is only built when CONFIG_ISA=y.  Is there any
>> reason to always have it whit PCI?
> 
> It's occasionally useful with PCI && !ISA.  It's pretty useless with
> !PCI && !ISA.
> 
>> Paul, can I send you that fix, or should I send it to
>> someone else?
> 
> Send it to Andrew Morton.

For anyone interested, I sent that out here:

  http://lkml.org/lkml/2006/8/29/374

-Geoff
