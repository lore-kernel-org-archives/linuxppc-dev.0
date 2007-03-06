Return-Path: <paul@briny.ondioline.org>
Received: from jenny.ondioline.org (jenny.ondioline.org [66.220.1.122])
	by ozlabs.org (Postfix) with ESMTP id E3F0DDDF1F
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 13:23:45 +1100 (EST)
From: Paul Collins <paul@briny.ondioline.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: PROBLEM: 2.6.20-1 not working on ibook g4 (BUG/Oops)
References: <200703051414.15802.frafore@tiscali.it>
	<1173143894.3461.240.camel@pmac.infradead.org>
Date: Tue, 06 Mar 2007 14:53:22 +1300
In-Reply-To: <1173143894.3461.240.camel@pmac.infradead.org> (David Woodhouse's
	message of "Tue\, 06 Mar 2007 01\:18\:14 +0000")
Message-ID: <87tzwzqgrx.fsf@briny.internal.ondioline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: francesco foresti <frafore@tiscali.it>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse <dwmw2@infradead.org> writes:

> On Mon, 2007-03-05 at 14:13 +0100, francesco foresti wrote:
>> Hi,
>> i'm having problems trying to use 2.6.20-1 (taken from kernel.org, not 
>> patched) on my ibook g4 (debian testing/unstable): 
>> i'm getting two errors while trying to boot up, and i can only report the 
>> second one because the other slips offscreen before i can see what's going 
>> on. However, this is what i have been able to hand-copy:
>>  
>> kernel BUG at mm/slab.c:610!
>> Oops: Exception in kernel mode, sig: 5 [#2]
[snipped]
> I've been seeing very similar behaviour with 2.6.20 on all pmac32
> hardware. I haven't yet tried hard to reproduce on non-pmac.

In case it's of interest, 2.6.20 has been running fine on my PowerBook5,4.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
