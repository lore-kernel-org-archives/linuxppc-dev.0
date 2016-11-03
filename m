Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8gMc0mwzzDvRB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 20:55:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jim Davis <jim.epost@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com, kernel-janitors@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix error handling
In-Reply-To: <CA+r1ZhixdKcgKDR3_No_5=M7BFo25M9mwfyxcVMLjfi=8Dtdmg@mail.gmail.com>
References: <20161030214047.25037-1-christophe.jaillet@wanadoo.fr>
 <87wpgp13ki.fsf@concordia.ellerman.id.au>
 <CA+r1ZhiJW6xQ1VwgLudFzFBxkKzkURv7MZhWtmSevRHc9aUyxA@mail.gmail.com>
 <87eg2unnil.fsf@concordia.ellerman.id.au>
 <CA+r1ZhixdKcgKDR3_No_5=M7BFo25M9mwfyxcVMLjfi=8Dtdmg@mail.gmail.com>
Date: Thu, 03 Nov 2016 20:55:55 +1100
Message-ID: <87wpgknaz8.fsf@concordia.ellerman.id.au>
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

Jim Davis <jim.epost@gmail.com> writes:

> On Wed, Nov 2, 2016 at 4:12 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Jim Davis <jim.epost@gmail.com> writes:
>>
>>> On Sun, Oct 30, 2016 at 10:37 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>>> More here:
>>>>
>>>> https://github.com/linuxppc/linux/wiki/Building-powerpc-kernels
>>>
>>> Cool; the little-endian build worked fine, but
>>
>> Yay, thanks for trying.
>>
>>> jim@krebstar:~/linux-rc$ make ARCH=powerpc
>>> CROSS_COMPILE=powerpc64-linux-gnu- vmlinux
>>> make: powerpc64-linux-gnu-gcc: Command not found
>>> make: powerpc64-linux-gnu-gcc: Command not found
>>> scripts/kconfig/conf  --silentoldconfig Kconfig
>>> make: powerpc64-linux-gnu-gcc: Command not found
>
> But I cleverly tried to run the Fedora command on Ubuntu... when I run
> the right command for Ubuntu, the build worked just fine.  D'oh!
>
> Nit: make distclean missed a few files

Ah thanks. I literally never do that, but it is supposed work. Have
filed a bug for it.

cheers
