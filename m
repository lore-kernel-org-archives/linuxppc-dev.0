Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 64CB11A0010
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 13:07:21 +1000 (EST)
Message-ID: <53BB6067.1090402@roeck-us.net>
Date: Mon, 07 Jul 2014 20:07:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Nick Krause <xerofoify@gmail.com>, benh@kernel.crashing.org
Subject: Re: Allyesconfig for powerpc still Failing
References: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
In-Reply-To: <CAPDOMVi5ptjaKzT+Exd3XtKcy7W7nNZYUD+MEwN8LmhPrQTZBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: mahesh@linux.vnet.ibm.com, agraf@suse.de,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 michael@ellerman.id.au, paulus@samba.org, anton@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2014 07:45 PM, Nick Krause wrote:
> Today I tested the allyesconfig for powerpc and it seems to be still
> failing according to my tests.
> Below are the error messages I get before the jobs finish and exit
> failing the build.
> Cheers Nick
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:1331: Error: attempt to move .org backwards
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> make: *** Waiting for unfinished jobs....

I submitted a patch to work around this problem a couple of weeks ago [1].
Unfortunately, with this patch applied, allyesconfig still fails with
relocation errors, but at least the above message is gone, and
allmodconfig passes.

Maybe we can convince Ben to accept the patch ...

Thanks,
Guenter

---
[1] https://lkml.org/lkml/2014/6/30/607
