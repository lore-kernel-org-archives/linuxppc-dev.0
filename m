Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYTtl63JxzDqjr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 May 2017 23:02:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Rob Landley  <rob@landley.net>, Andrew Morton  <akpm@linux-foundation.org>
Subject: Re: [linux-next] PPC Lpar fail to boot with error hid: module
 verification failed: signature and/or required key missing - tainting kernel
In-Reply-To: <1495700957.9020.43.camel@abdul.in.ibm.com>
References: <1495700957.9020.43.camel@abdul.in.ibm.com>
Date: Thu, 25 May 2017 23:02:06 +1000
Message-ID: <8760gp9jjl.fsf@concordia.ellerman.id.au>
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

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> Test : boot
> Machine : Power 8 PowerVM LPAR
> Kernel version : 4.12.0-rc2-next-20170524
> Toolchain : gcc version 5.2.1
> Config : attached
>
> next-20170517 was last good version where we did not see the failure.
> from next-20170519 to today's next-20170524, we see the problem
> everyday.
>
> Kernels fails to boot on PowerVM LPAR with these errors;
>
> Freeing unused kernel memory: 4416K
> This architecture does not have kernel memory protection.
> Loading, please wait...
> mount: mounting udev on /dev failed: Device or resource busy
> W: devtmpfs not available, falling back to tmpfs for /dev

It'll be:

ee35011fd032 ("initramfs: make initramfs honor CONFIG_DEVTMPFS_MOUNT")

cheers
