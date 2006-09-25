Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BAA5667B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 15:21:34 +1000 (EST)
In-Reply-To: <4B6C3D97-1872-447A-AEE3-011E0A34298A@kernel.crashing.org>
References: <20060920215738.GC24809@mag.az.mvista.com>
	<C2AFCB31-CFC2-4B0E-ADAE-380A612D1053@kernel.crashing.org>
	<20060921133707.GA29137@gate.crashing.org>
	<1CA5168F-9ECA-4AA2-92AE-F86579245855@kernel.crashing.org>
	<20060922012408.GA13820@mag.az.mvista.com>
	<9F654F4A-B344-4374-8BDC-77FB0DDAFDCC@kernel.crashing.org>
	<20060922185923.GB25738@mag.az.mvista.com>
	<74E4B2E4-B59C-4998-B9FC-A77245C6AF6B@kernel.crashing.org>
	<20060923081836.GA25298@mag.az.mvista.com>
	<D47FC822-2AB1-459A-B2EC-50A99552DC9A@kernel.crashing.org>
	<20060925175307.GC4971@mag.az.mvista.com>
	<4B6C3D97-1872-447A-AEE3-011E0A34298A@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <600DC8BB-EBC3-4DC9-8B5C-68A99A004EBA@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Start arch/powerpc/boot code reorganization
Date: Tue, 26 Sep 2006 01:44:47 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Matt Porter <mporter@embeddedalley.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> All I'm try to say is that "fw,address" is just like the "reg"
>>>> property
>>>> except that it holds the effective addr not the physical addr and
>>>> the
>>>> size of the address is determined by the existence of "/cpus/64- 
>>>> bit"
>>>> not #address-cells.  That's all.

Oh and use "/cpus/<some-cpu>/64-bit", not a property directly in
the "/cpus" node.


Segher
