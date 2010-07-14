Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D259B6EEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 01:45:26 +1000 (EST)
In-Reply-To: <1279122163.13098.2.camel@localhost>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<C26140FB-4F77-4D8E-B6C4-63BC9C9EDD83@kernel.crashing.org>
	<1279122163.13098.2.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FFCEA7A1-6F2B-402F-A698-C882D0B4EB2E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
Date: Wed, 14 Jul 2010 17:46:48 +0200
To: Matthew McClintock <msm@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Any particular reason you fixed only one of the two
>> mispelings I pointed out?  (device tree is two words,
>> not one).
>
> Ahh, my fault.

Well I wasn't terribly clear ;-)

>> You could use one property instead of two; use addr+len
>> like every other property does.
>>
>> You also should use a better name for the property; is this
>> the previous kernel's device tree?  Just "device-tree" makes
>> no sense, it is not pointing to "the" device tree for sure!
>
> What about just one node called "flat-device-tree"?

But *what* flat device tree?  It cannot be "the" flat device tree,
or it would be useless information, since we are already reading it!


Segher
