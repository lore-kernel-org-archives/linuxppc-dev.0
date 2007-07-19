Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C6FCDDFA5
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:04:46 +1000 (EST)
In-Reply-To: <469FDBDC.5030700@am.sony.com>
References: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
	<469FDBDC.5030700@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A127B558-BA1C-4F18-890B-7052F2DF7488@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PS3: Fix build with 32-bit toolchains
Date: Thu, 19 Jul 2007 17:05:14 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 19, 2007, at 4:47 PM, Geoff Levand wrote:

> The PS3 bootwrapper files use instructions only available on
> 64-bit CPUs.  Add the code generation directive '.machine "ppc64"'
> for toolchains configured for 32-bit CPUs.
>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

while this is a fix, why are we even building it Grant's case of  
building 834x itx.

- k
