Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwF5S5bv0zDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Apr 2017 21:31:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Cc: xinhui.pan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/3] powerpc/xmon: drop the nobt option from xmon plus
 minor fixes
In-Reply-To: <38390ee4-b1ea-7be7-1095-2706aca5faae@linux.vnet.ibm.com>
References: <20170322192751.30531-1-gpiccoli@linux.vnet.ibm.com>
 <20170322192751.30531-3-gpiccoli@linux.vnet.ibm.com>
 <20170331003645.GA12861@fergus.ozlabs.ibm.com>
 <38390ee4-b1ea-7be7-1095-2706aca5faae@linux.vnet.ibm.com>
Date: Sat, 01 Apr 2017 21:31:07 +1100
Message-ID: <87shlsa07o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> On 03/30/2017 09:36 PM, Paul Mackerras wrote:
>> On Wed, Mar 22, 2017 at 04:27:50PM -0300, Guilherme G. Piccoli wrote:
>>> The xmon parameter nobt was added long time ago, by commit 26c8af5f01df
>>> ("[POWERPC] print backtrace when entering xmon"). The problem that time
>>> was that during a crash in a machine with USB keyboard, xmon wouldn't
>>> respond to commands from the keyboard, so printing the backtrace wouldn't
>>> be possible.
>>>
>>> Idea then was to show automatically the backtrace on xmon crash for the
>>> first time it's invoked (if it recovers, next time xmon won't show
>>> backtrace automatically). The nobt parameter was added _only_ to prevent
>>> this automatic trace show. Seems long time ago USB keyboards didn't work
>>> that well!
>> 
>> Xmon still can't use a USB keyboard.  It's not a question of how well
>> USB keyboards work, it's that having a non-interrupt-driven USB stack
>> with (at least) an OHCI host controller driver and a keyboard driver
>> in xmon is impractical.
>
> That's nice to know Paul, thank you. Fortunately, we kept the automatic
> trace showing feature!
>
> Seems my commit message was unfortunate/wrong in this aspect, though.
> @mpe, if you wanna change, feel free. Although it's not essential...

It's already merged, so it is what it is.

I do remember not quite understanding what you meant with the "long time
ago" bit, but didn't think much more of it.

cheers
