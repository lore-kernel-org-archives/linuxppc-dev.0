Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cJ4t1mXjzDqkJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 15:51:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] selftests/powerpc: Only run some tests on ppc64le
In-Reply-To: <6f71e169-7d73-9128-5cff-72efcf734e7d@linux.vnet.ibm.com>
References: <20180726122459.9293-1-mpe@ellerman.id.au>
 <20180726122459.9293-2-mpe@ellerman.id.au>
 <6f71e169-7d73-9128-5cff-72efcf734e7d@linux.vnet.ibm.com>
Date: Fri, 27 Jul 2018 15:51:55 +1000
Message-ID: <87pnz9z0n8.fsf@concordia.ellerman.id.au>
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

Gustavo Romero <gromero@linux.vnet.ibm.com> writes:

> Hi Michael,
>
> On 07/26/2018 09:24 AM, Michael Ellerman wrote:
>> These tests are currently failing on (some) big endian systems. Until
>> we can fix that, skip them unless we're on ppc64le.
>
> I can take a look at this.

Thanks!

> Is that the same issue related to the gcc version we discussed a month ago?

Maybe, I've forgotten :)

> If not, could you provide the crash logs as a starting point?

There's not much:

  test: tm_tar
  tags: git_version:9794259
  failure: tm_tar
  run-parts: ./tm-tar exited with return code 1
  
  test: tm_vmxcopy
  tags: git_version:9794259
  !! child died by signal 11
  failure: tm_vmxcopy
  run-parts: ./tm-vmxcopy exited with return code 1

And now I can't get the sigreturn one to fail :/


cheers
