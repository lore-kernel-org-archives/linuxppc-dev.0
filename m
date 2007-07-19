Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 56281DDDFC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 08:36:32 +1000 (EST)
Message-ID: <469FE75D.6000402@am.sony.com>
Date: Thu, 19 Jul 2007 15:36:13 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PS3: Fix build with 32-bit toolchains
References: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
	<469FDBDC.5030700@am.sony.com>
	<A127B558-BA1C-4F18-890B-7052F2DF7488@kernel.crashing.org>
In-Reply-To: <A127B558-BA1C-4F18-890B-7052F2DF7488@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
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

Kumar Gala wrote:
> On Jul 19, 2007, at 4:47 PM, Geoff Levand wrote:
> 
>> The PS3 bootwrapper files use instructions only available on
>> 64-bit CPUs.  Add the code generation directive '.machine "ppc64"'
>> for toolchains configured for 32-bit CPUs.
>>
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> while this is a fix, why are we even building it Grant's case of  
> building 834x itx.

I originally had the makefile setup to conditionally build these
files on CONFIG_PPC_PS3, but during the review I was requested to
change it to build them unconditionally.  See:

  http://ozlabs.org/pipermail/linuxppc-dev/2007-June/038072.html

-Geoff
