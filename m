Return-Path: <jwboyer@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id 15087DDED3
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 10:36:02 +1100 (EST)
Received: by ewy14 with SMTP id 14so1296423ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 15:35:59 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 12 Feb 2009 18:35:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add new ISA 2.06 page sizes and
	MAS defines
Message-ID: <20090212233551.GB2385@yoda.jdub.homelinux.org>
References: <1234311976-22026-1-git-send-email-galak@kernel.crashing.org>
	<4B32B56D-9BCC-4ABA-A2AD-BCACFB30D18F@kernel.crashing.org>
	<20090212203409.GA2385@yoda.jdub.homelinux.org>
	<54A20554-3C7B-4EE7-B3CF-362AEB27CA64@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54A20554-3C7B-4EE7-B3CF-362AEB27CA64@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 03:58:15PM -0600, Kumar Gala wrote:
>
> On Feb 12, 2009, at 2:34 PM, Josh Boyer wrote:
>
>> On Thu, Feb 12, 2009 at 01:21:24PM -0600, Kumar Gala wrote:
>>>
>>> On Feb 10, 2009, at 6:26 PM, Kumar Gala wrote:
>>>
>>>> The Power ISA 2.06 added power of two page sizes to the embedded MMU
>>>> architecture.  Its done it such a way to be code compatiable with  
>>>> the
>>>> existing HW.  Made the minor code changes to support both power of  
>>>> two
>>>> and power of four page sizes.  Also added some new MAS bits and  
>>>> macros
>>>> that are defined as part of the 2.06 ISA.
>>>>
>>>> Note, its still invalid to try and use a page size that isn't
>>>> supported
>>>> by cpu.
>>>>
>>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>>> ---
>>>> * Fixed MAS6_ISIZE macro
>>>>
>>>> arch/powerpc/include/asm/mmu-fsl-booke.h |   54 +++++++++++++++++++
>>>> +----------
>>>
>>> Do you want to rename asm/mmu-fsl-booke.h => mmu-booke.h (per ISA  
>>> 2.06
>>> changes)?
>>
>> Misleading perhaps.  ISA 2.06 is really new and we've been calling 4xx
>> and FSL booke for a while now.
>
> I can call it mmu-book3e.h if you think that might enough different to  
> convey the ISA 2.06 fact that the FSL style MMU is now part of the 3e  
> architecture.

Yep, sounds great.  "What's in a name..", right? :)

josh
