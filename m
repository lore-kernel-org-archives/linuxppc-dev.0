Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CE5ABDDE22
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Aug 2007 09:40:48 +1000 (EST)
In-Reply-To: <46BCE5AA.4060805@am.sony.com>
References: <E1IDjSy-0003eC-T4@jdl.com>	<20070726030550.GA1149@localhost.localdomain>	<E1IE314-0000qF-5x@jdl.com>	<20070726142739.GB18684@localhost.localdomain>	<E1IE59h-0001tt-JE@jdl.com>	<20070727013331.GB1561@localhost.localdomain>	<20070806084813.5432ba91@weaponx.rchland.ibm.com>	<20070810013001.GF17370@localhost.localdomain>	<20070809203754.2e9192c5@zod.rchland.ibm.com>	<20070810025944.GI17370@localhost.localdomain>
	<f54fc5f2d8c125a2f07c38bac6e998f8@kernel.crashing.org>
	<46BCE5AA.4060805@am.sony.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14e38e0bcbd694a572f6c3da59340483@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTC 1.0.0 Release Coming?
Date: Sat, 11 Aug 2007 01:39:59 +0200
To: Geoff Levand <geoffrey.levand@am.sony.com>
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

>>> We decided that since a formal dtc release was imminent, it would be
>>> simpler to make dtc a new kernel build requirement,
>>
>> For _all_ kernel builds?  Most people building a powerpc
>> kernel don't need it.
>
> The dtc is run from the wrapper script, so if you build for a platform
> that uses a dts source file, then you'll need the dtc.

That should be fine then.  We'll see :-)


Segher
