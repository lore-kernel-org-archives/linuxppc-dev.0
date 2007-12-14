Return-Path: <galak@kernel.crashing.org>
Message-Id: <22D9D05D-03E6-4A9E-BF2A-6C607AF620B3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1197612373.10259.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix rounding bug in emulation for double floatoperating
Date: Fri, 14 Dec 2007 00:14:30 -0600
References: <11972628522442-git-send-email-b13201@freescale.com>
	<20071210045616.GC29611@localhost.localdomain>
	<6EBEC19BF4A8F843BCD6B9155BBE2515C79D0D@zch01exm26.fsl.freescale.net>
	<AD0028E8-E305-443F-8872-C935D4E18F80@kernel.crashing.org>
	<1197343143.13519.2.camel@localhost.localdomain>
	<A069B515-C07A-4471-9473-7A7E29F12685@kernel.crashing.org>
	<1197448223.29372.12.camel@localhost.localdomain>
	<BB2AC24A-6336-4270-9124-734BCC09F7DA@kernel.crashing.org>
	<1197612373.10259.9.camel@localhost.localdomain>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Liu Yu <B13201@freescale.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 12:06 AM, Zang Roy-r61911 wrote:

> On Fri, 2007-12-14 at 13:46, Kumar Gala wrote:
>>>> When I run this on a G5 (w/HW FP) I get:
>>>>
>>>> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
>>>> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
>>>> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
>>>>
>>>> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
>>>>
>>>> and on the 85xx w/FP emu:
>>>>
>>>> dmul 3fe0000000000000 * 1 = 0 expected 0 (PASS)
>>>> dmul bfe0000000000000 * 1 = 8000000000000000 expected 0 (PASS)
>>>> dmul 8000000000000001 * bfe0000000000000 = 0 expected 0 (PASS)
>>>>
>>>> ddiv 1 / 4000000000000000 = 0 expected 0 (PASS)
>>>>
>>>> Maybe I'm missing where the error is.
>>> I am missing ...
>>> It is supposed to run based on previous IEEE 754 patch.
>>> http://ozlabs.org/pipermail/linuxppc-dev/2007-February/031351.html
>>
>> I'd really like to see to see a testcase show the issue with "classic
>> FP emu" on a 85xx system.
> I can understand.
> You know, For a 85xx system without the previous patch or other
> 'classic' powerpc, it is hard to trigger this issue. Although I  
> believe
> it is a problem fixed up.
> Do you have any idea?

maybe I'm missing it, but can we not do the same operation w/classic  
FP that you are doing w/SPE fp?

is this in standard rounding mode, etc?

- k
