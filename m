Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7d7y1S1YzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 12:11:58 +1000 (AEST)
Subject: Re: [PATCH] powerpc: vdso: Add missing include file
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1470524052-27133-1-git-send-email-linux@roeck-us.net>
 <877fbqsoio.fsf@concordia.ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <68fbcd6c-2485-fe5b-902f-c07c8796b0f6@roeck-us.net>
Date: Mon, 8 Aug 2016 19:11:52 -0700
MIME-Version: 1.0
In-Reply-To: <877fbqsoio.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2016 06:46 PM, Michael Ellerman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> Some powerpc builds fail with the following buld error.
>
> Is that a randconfig?
>

No, it is a configuration I use for qemu testing.

https://github.com/groeck/linux-build-test/blob/master/rootfs/ppc64/qemu_ppc64_e5500_defconfig

Guenter
