Return-Path: <jwboyer@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id 63D20DDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 07:34:35 +1100 (EST)
Received: by fxm4 with SMTP id 4so3925318fxm.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 12:34:32 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 12 Feb 2009 15:34:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add new ISA 2.06 page sizes and
	MAS defines
Message-ID: <20090212203409.GA2385@yoda.jdub.homelinux.org>
References: <1234311976-22026-1-git-send-email-galak@kernel.crashing.org>
	<4B32B56D-9BCC-4ABA-A2AD-BCACFB30D18F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B32B56D-9BCC-4ABA-A2AD-BCACFB30D18F@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 12, 2009 at 01:21:24PM -0600, Kumar Gala wrote:
>
> On Feb 10, 2009, at 6:26 PM, Kumar Gala wrote:
>
>> The Power ISA 2.06 added power of two page sizes to the embedded MMU
>> architecture.  Its done it such a way to be code compatiable with the
>> existing HW.  Made the minor code changes to support both power of two
>> and power of four page sizes.  Also added some new MAS bits and macros
>> that are defined as part of the 2.06 ISA.
>>
>> Note, its still invalid to try and use a page size that isn't  
>> supported
>> by cpu.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> * Fixed MAS6_ISIZE macro
>>
>> arch/powerpc/include/asm/mmu-fsl-booke.h |   54 +++++++++++++++++++ 
>> +----------
>
> Do you want to rename asm/mmu-fsl-booke.h => mmu-booke.h (per ISA 2.06  
> changes)?

Misleading perhaps.  ISA 2.06 is really new and we've been calling 4xx
and FSL booke for a while now.

josh
