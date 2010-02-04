Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 66C0DB7D53
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Feb 2010 00:03:09 +1100 (EST)
Message-ID: <4B6AC587.5060608@suse.cz>
Date: Thu, 04 Feb 2010 14:03:03 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 2/2] kbuild: move -fno-dwarf2-cfi-asm to powerpc only
References: <201002022240.o12Me3aI018845@imap1.linux-foundation.org>
	<1265239339.8287.126.camel@pasglop>
In-Reply-To: <1265239339.8287.126.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: ak@linux.intel.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	andi@firstfloor.org, kyle@mcmartin.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4.2.2010 00:22, Benjamin Herrenschmidt wrote:
> On Tue, 2010-02-02 at 14:40 -0800, akpm@linux-foundation.org wrote:
>> From: Andi Kleen <andi@firstfloor.org>
>>
>> Better dwarf2 unwind information is a good thing, it allows better
>> debugging with kgdb and crash and helps systemtap.
>>
>> Commit 003086497f07f7f1e67c0c295e261740f822b377 ("Build with
>> -fno-dwarf2-cfi-asm") disabled some CFI information globally to work
>> around a module loader bug on powerpc.
>>
>> But this disables the better unwind tables for all architectures, not just
>> powerpc.  Move the workaround to powerpc and also add a suitable comment
>> that's it really a workaround.
>>
>> This improves dwarf2 unwind tables on x86 at least.
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>> Cc: Kyle McMartin <kyle@mcmartin.ca>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Do you want me to carry that in powerpc-next ?

I can add it to kbuild-next. Changes to the top-level Makefile usually
go through kbuild, so it will avoid potential conflicts.

Michal
