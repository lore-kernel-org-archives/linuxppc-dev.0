Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7ZBx1l0hzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 18:59:05 +1000 (AEST)
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
To: Andreas Schwab <schwab@linux-m68k.org>, Alan Modra <amodra@gmail.com>
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
 <20160516062425.GA24091__32035.8907142237$1463379977$gmane$org@bubble.grove.modra.org>
 <m21t52xu92.fsf@linux-m68k.org>
Cc: linuxppc-dev@lists.ozlabs.org
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <adca8a90-b4ce-f386-5706-0a17b1e91441@redhat.com>
Date: Mon, 16 May 2016 10:59:00 +0200
MIME-Version: 1.0
In-Reply-To: <m21t52xu92.fsf@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2016 10:49 AM, Andreas Schwab wrote:

>>  (If
>> I'm wrong about heap+stack needing the same protection then I can't
>> think of any reason to require an executable heap.)
>
> The heap and the BSS initially share the same page.

But my test says that at least part of .bss in the main executable is 
*not* executable.

Any ideas why the kernel behaves the way it does?  Can we change the 
behavior at least for ELF binaries which use glibc (or something else 
which indicates a non-legacy binary)?

Thanks,
Florian
