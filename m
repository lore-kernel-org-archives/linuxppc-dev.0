Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-9.online-age.net (ext-nj2ut-9.online-age.net
	[64.14.54.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 48234DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 23:23:00 +1100 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-9.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n13CMuUT006699
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Feb 2009 07:22:56 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n13CMpel009307
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Feb 2009 07:22:56 -0500
Message-ID: <49883719.9030300@gefanuc.com>
Date: Tue, 03 Feb 2009 12:22:49 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
References: <4982F311.4050507@gefanuc.com>	
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>	
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>	
	<4986BEB9.3030606@gefanuc.com>	
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>	
	<498718B6.3030307@gefanuc.com>	
	<D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>	
	<49871D3E.80809@gefanuc.com> <1233607753.18767.103.camel@pasglop>
In-Reply-To: <1233607753.18767.103.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>>> commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
>>>> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>
>>>>   powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
>>>>
>>>> I tried reverting it, but as I had kinda thought, that really didn't 
>>>> help.
>>>>
>>>> I'm just recompiling to check that I didn't screw-up during the 
>>>> bisection.
> 
> Is this a chip that must not have M set ? Or something else ? You guys
> have to help if you CC me, I have about 0 idea what a MPC8661d is :-)
> 

Sorry, my fault. It's a Freescale SOC with two e600 cores. Beyond that, I'm afraid I'm a little out of my depth. 

> Also, does 4c456a67f501b8b15542c7c21c28812bf88f484b help ?

I believe that to be included in 2.6.29-rc3 if my (rather rudimentary) git skills haven't let me down? The problem persists in 2.6.29-rc3.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
