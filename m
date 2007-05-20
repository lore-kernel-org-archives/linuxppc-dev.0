Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CE0ADDDF4
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 01:35:52 +1000 (EST)
In-Reply-To: <20070520102132.GB22091@uranus.ravnborg.org>
References: <20070515201914.16944e04.akpm@linux-foundation.org>
	<200705201212.50810.m.kozlowski@tuxland.pl>
	<20070520102132.GB22091@uranus.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8F6C900-F982-42E9-94A5-97A00793EFA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.22-rc1-mm1
Date: Sun, 20 May 2007 10:33:58 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2007, at 5:21 AM, Sam Ravnborg wrote:

> On Sun, May 20, 2007 at 12:12:50PM +0200, Mariusz Kozlowski wrote:
>> Hello,
>>
>> 	I tried it on iMac G3. I got a bunch of warnings
>> and finally it failed to build.
>>
>> WARNING: "fee_restarts" [arch/powerpc/kernel/built-in] is COMMON  
>> symbol
>> WARNING: "ee_restarts" [arch/powerpc/kernel/built-in] is COMMON  
>> symbol
>> WARNING: arch/powerpc/kernel/built-in.o - Section mismatch:  
>> reference to .init.data:.got2 from dt_string_start (offset 0x8)
> ....
>
> Most - but not all of these warnings should be gone when
> Linus pulls kbuild-fix.git.
> When -rc3 is ready can you then please post the result of a build.
> Then I can take a look at the remaining section mismatch warnings.

Also, I've got fixes for the COMMON symbol warnings.

- k
