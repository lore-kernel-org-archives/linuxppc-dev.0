Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A42E3DE035
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:29:13 +1000 (EST)
Message-Id: <4E9DFCDB-CEFF-4747-8F22-4BF9EDD92473@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <E7B91ECF-0D87-442D-B99A-1BBB14697E09@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: New fsl device bindings file
Date: Mon, 7 Jul 2008 10:28:53 -0500
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<486D1A58.8010403@freescale.com>
	<fa686aa40807031134s4ddd0cabj1b31d3ee2d9d2258@mail.gmail.com>
	<8C77F02F-E930-40EB-AE25-F959C40833B3@lixom.net>
	<20080707013902.GI6267@yookeroo.seuss>
	<E7B91ECF-0D87-442D-B99A-1BBB14697E09@lixom.net>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 6, 2008, at 8:45 PM, Olof Johansson wrote:

>
> On Jul 6, 2008, at 8:39 PM, David Gibson wrote:
>
>> Well... they may be Linux specific by default, but they're supposed  
>> to
>> be general enough that they (or at least, very small extensions)
>> *could* become official OF bindings, if there was still an OF group  
>> to
>> make them so.  It certainly should be possible to use these bindings
>> in a firmware which provides an OF client interface as well as in
>> flat-tree-only firmwares which don't.
>
> Right, it's a classic case of embrace and extend. Calling it OF is  
> just plain misleading, especially since the original document was  
> called booting _WITHOUT_ OF.

I agree With Olof and plain on calling it:

Documentation/powerpc/dts-bindings/fsl/

- k
