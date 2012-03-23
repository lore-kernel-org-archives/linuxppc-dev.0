Return-Path: <arjan@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id C8911B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2012 06:34:34 +1100 (EST)
Message-ID: <4F6CCDDC.5000802@linux.intel.com>
Date: Fri, 23 Mar 2012 12:24:12 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Boot failure with next-20120208
References: <20120212113805.c7e5d902c95a9d0f4037e12c@canb.auug.org.au>
 <16788.1329102254@neuling.org> <4F391BBA.5020506@linux.intel.com>
 <20120213120549.eab7e2b9.akpm@linux-foundation.org>
 <4F396FA9.90606@linux.intel.com>
 <20120323122244.132198e3.akpm@linux-foundation.org>
In-Reply-To: <20120323122244.132198e3.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, gregkh@linuxfoundation.org,
 LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>,
 linux-next@vger.kernel.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/23/2012 12:22 PM, Andrew Morton wrote:
> On Mon, 13 Feb 2012 12:16:41 -0800
> Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>> The bug looks pretty generic, nothing very PPC-specific there.  It 
>>> might affect other architectures - we won't know until we find out
>>> wht caused it.
>>
>> well one half of the race looks pretty generic...
>> ..... doesn't mean the other half of the race is though....
>>
>>
>>>
>>> Ho hum, I suppose I should pull the patch out of linux-next, to
>>> avoid disrupting other testing.  This means it's going to be hard
>>> to get the bug fixed.
>>
>> it means losing this one big PPC machine indeed.... until they hit
>> that same race some other way with regular real cpu hotplug ;-(
> 
> So we're kinda stuck with this.  As I can't merge it, I guess I'll make
> smp-start-up-non-boot-cpus-asynchronously.patch disappear.


well yeah, PPC is throwing things in the spanner

we're now working on an x86-only patch with basically the same
improvement, but done in a way that does not touch the other architectures

so by all means drop the patch
