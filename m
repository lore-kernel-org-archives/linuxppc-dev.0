Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GQpr0C0nzDqwb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 22:52:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/64s/idle: POWER9 implement a separate idle stop
 function for hotplug
In-Reply-To: <20180404031352.2281c7a1@roar.ozlabs.ibm.com>
References: <20171117140807.22105-2-npiggin@gmail.com>
 <40Fv5c0X41z9s4b@ozlabs.org> <20180404031352.2281c7a1@roar.ozlabs.ibm.com>
Date: Wed, 04 Apr 2018 22:52:35 +1000
Message-ID: <87d0zfcewc.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:
> On Wed,  4 Apr 2018 02:03:18 +1000 (AEST)
> Michael Ellerman <patch-notifications@ellerman.id.au> wrote:
>> On Fri, 2017-11-17 at 14:08:05 UTC, Nicholas Piggin wrote:
>> > Implement a new function to invoke stop, power9_offline_stop, which is
>> > like power9_idle_stop but used by the cpu hotplug code.
>> > 
>> > Move KVM secondary state manipulation code to the offline case.
>> > 
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>  
>> 
>> Applied to powerpc next, thanks.
>> 
>> https://git.kernel.org/powerpc/c/3d4fbffdd703d2b968db443911f214
>
> I sent out a new series for this which is rebased and a bit cleaner.
> I probably wasn't clear enough about the change, sorry.

No that's OK, I just already had the previous series applied (partially)
in my testing tree and didn't see the new series in time to back it out.

> This patch will need to be adjusted for the force SMT4 change. The
> end result should look like this,
>
> https://patchwork.ozlabs.org/patch/893948/

Thanks. I did a patch to get everything in sync, and confirmed the
result is the same as applying your new series.

cheers
