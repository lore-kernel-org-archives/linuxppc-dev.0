Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <4CB813ED-9D8B-4A32-B4AC-65D27741D46C@kernel.crashing.org>
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
	<8CA741AA-D200-474F-943D-ECE4B3ACD38B@kernel.crashing.org>
	<18068.5706.700933.551828@cargo.ozlabs.ibm.com>
	<89E626D4-D48D-4062-A996-E2DFFE8248E3@kernel.crashing.org>
	<20070717024246.GA6482@localhost.localdomain>
	<4CB813ED-9D8B-4A32-B4AC-65D27741D46C@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B07FAF3D-A8F4-45F5-8EEF-4506F4A31DF2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Tue, 17 Jul 2007 11:30:58 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 10:18 AM, Segher Boessenkool wrote:

>>>>> Yeah.  Giving the warning is a good thing though.
>>>>
>>>> No, it isn't; it's just noise, if we're not ever going to do
>>>> anything
>>>> to prevent the behaviour - and we can't.
>>>
>>> The same userland code will not run correctly on PPC64 or BookE
>>> systems.  Is that not a reason to warn?
>>
>> Way back when, I distinctly recall aborting my plans to implement
>> per-page exec on 40x, precisely because of executables like this.
>
> I noticed some comments to that effect in the BookE code,
> yes.  It seems userland has been fixed enough that you
> could think about enabling it again FWIW.

Did I miss the posting of the patch with the fix?

- k
