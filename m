Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6F7DDDEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 08:24:53 +1000 (EST)
Message-ID: <46BCE5AA.4060805@am.sony.com>
Date: Fri, 10 Aug 2007 15:24:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTC 1.0.0 Release Coming?
References: <E1IDjSy-0003eC-T4@jdl.com>	<20070726030550.GA1149@localhost.localdomain>	<E1IE314-0000qF-5x@jdl.com>	<20070726142739.GB18684@localhost.localdomain>	<E1IE59h-0001tt-JE@jdl.com>	<20070727013331.GB1561@localhost.localdomain>	<20070806084813.5432ba91@weaponx.rchland.ibm.com>	<20070810013001.GF17370@localhost.localdomain>	<20070809203754.2e9192c5@zod.rchland.ibm.com>	<20070810025944.GI17370@localhost.localdomain>
	<f54fc5f2d8c125a2f07c38bac6e998f8@kernel.crashing.org>
In-Reply-To: <f54fc5f2d8c125a2f07c38bac6e998f8@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>> Actually, after discussions with Stephen and Paulus, we decided not 
>>>> to
>>>> take this route.  In any case having Kbuild like versioning wouldn't
>>>> actually help us any in integrating into a full Kbuild system.
>>>
>>> Can you elaborate why you decided not to?  I'm just curious.
>>
>> We decided that since a formal dtc release was imminent, it would be
>> simpler to make dtc a new kernel build requirement,
> 
> For _all_ kernel builds?  Most people building a powerpc
> kernel don't need it.

The dtc is run from the wrapper script, so if you build for a platform
that uses a dts source file, then you'll need the dtc.  If you don't
build for one of those platforms, then you won't needed it.

So a 'make allXXXconfig' needs the dtc to be installed since it
builds platforms that use dts source files.

-Geoff
