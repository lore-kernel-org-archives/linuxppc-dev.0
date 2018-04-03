Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fwg54Ky7zF29x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 03:14:09 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id v18-v6so7751809ply.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Apr 2018 10:14:09 -0700 (PDT)
Date: Wed, 4 Apr 2018 03:13:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Gautham R . Shenoy"
 <ego@linux.vnet.ibm.com>
Subject: Re: [1/3] powerpc/64s/idle: POWER9 implement a separate idle stop
 function for hotplug
Message-ID: <20180404031352.2281c7a1@roar.ozlabs.ibm.com>
In-Reply-To: <40Fv5c0X41z9s4b@ozlabs.org>
References: <20171117140807.22105-2-npiggin@gmail.com>
 <40Fv5c0X41z9s4b@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  4 Apr 2018 02:03:18 +1000 (AEST)
Michael Ellerman <patch-notifications@ellerman.id.au> wrote:

> On Fri, 2017-11-17 at 14:08:05 UTC, Nicholas Piggin wrote:
> > Implement a new function to invoke stop, power9_offline_stop, which is
> > like power9_idle_stop but used by the cpu hotplug code.
> > 
> > Move KVM secondary state manipulation code to the offline case.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>  
> 
> Applied to powerpc next, thanks.
> 
> https://git.kernel.org/powerpc/c/3d4fbffdd703d2b968db443911f214
> 
> cheers

I sent out a new series for this which is rebased and a bit cleaner.
I probably wasn't clear enough about the change, sorry.

This patch will need to be adjusted for the force SMT4 change. The
end result should look like this,

https://patchwork.ozlabs.org/patch/893948/

Thanks,
Nick
