Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjRX2QPXzDvvV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:11:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, kbuild test robot <lkp@intel.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kbuild-all@01.org
Subject: Re: [PATCH] powerpc/xmon: Add support for dump in reverse
In-Reply-To: <87eg25w2t8.fsf@concordia.ellerman.id.au>
References: <201611181011.JmH0m3H9%fengguang.wu@intel.com>
 <044f9dc1-c2aa-9798-f5ca-5bfb4796ef42@gmail.com>
 <87eg25w2t8.fsf@concordia.ellerman.id.au>
Date: Wed, 23 Nov 2016 11:11:03 +1100
Message-ID: <878tsbukbs.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> Actually I want you to rework the patch anyway :)
>
> Will talk tomorrow.

So as discussed, lets add d1, d2, d4, d8, which dump 1/2/4/8 bytes at a
time, in cpu endian, and which each value separated by space.

cheers
