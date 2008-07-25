Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB4EEDDF2D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 10:19:11 +1000 (EST)
In-Reply-To: <488912BC.6040706@mindspring.com>
References: <31a45a6b0f4087a6e54b05241eebc9f94202ffe5.1216681294.git.segher@kernel.crashing.org>
	<48872AB4.3010001@mindspring.com>
	<bd512e1b36a954819f09379908e342fb@kernel.crashing.org>
	<48882217.5010609@mindspring.com>
	<3c19f5225b292a011665f127c55e58f7@kernel.crashing.org>
	<488912BC.6040706@mindspring.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aad162859ed07fa69015df3d8b2b3e69@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix build bug with binutils < 2.18 and GCC < 4.2
Date: Fri, 25 Jul 2008 02:18:54 +0200
To: Chuck Meade <chuckmeade@mindspring.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I can help you by testing on 2.15.  Send me alternate vmlinux.lds.S 
>>> files
>>> to try, and I will test and get back to you ASAP.
>>
>> No, I will not send you randomly changed source files and hope they
>> will do something useful for you.  Instead, why not provide me the
>> information I asked for?  What target (arch/powerpc it sounds like?)
>> What _exact_ binutils version (FSF 2.15?)  What _exact_ GCC version
>> (FSF 3.4.4?)  What Linux config (either the full .config, or the
>> name of a defconfig)?
>
> No problem -- I thought it would be helpful to offer to test changes 
> for you,
> so we could work together toward a solution.

Sure, and thanks for that!  I need to be able to reproduce it myself
to create a patch in the first place though (or spend a few hundred
hours in a senseless guessing game) :-)

I now managed to reproduce it with 2.15 on powerpc64.  You should see
the patch soon (I sent it, but for seem reason it takes a while to
get through ozlabs, half an hour or so the last time).

Please test, and thank you!  Reply to the patch mail saying if it
worked please (Jon, Sean, you as well?).


Segher
