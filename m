Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E440DE0E1
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 03:29:20 +1100 (EST)
Message-Id: <5898D87A-231D-4CCB-9538-808562F08D57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071214155341.GB16269@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Date: Fri, 14 Dec 2007 10:28:35 -0600
References: <20071211212247.GB3620@loki.buserror.net>
	<EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
	<20071214155341.GB16269@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 9:53 AM, Scott Wood wrote:

> On Thu, Dec 13, 2007 at 11:19:33PM -0600, Kumar Gala wrote:
>> Can we make this a /dts-v1/; since its new.
>
> It's not really new; it's just been collecting dust for a while. :-P

Its new to us on the list :P

> Are there any tools to autoconvert (preferably without losing  
> comments)?

Not sure of jon had a perl script or something.

>>> +/ {
>>> +	model = "EP8248E";
>>> +	compatible = "fsl,ep8248e";
>>> +	#address-cells = <1>;
>>> +	#size-cells = <1>;
>>
>> Add a aliases { } and can we use that instead of linux,network-index
>> and linux,planetcore-label.
>
> I don't see any support in the current bootwrapper for aliases.

Yeah, I was hoping you'd code something up :)

- k
