Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ys5LD3tMVzF0GW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 15:32:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc/modules: Improve restore_r2() error message
In-Reply-To: <20171114092910.20399-4-kamalesh@linux.vnet.ibm.com>
References: <20171114092910.20399-1-kamalesh@linux.vnet.ibm.com>
 <20171114092910.20399-4-kamalesh@linux.vnet.ibm.com>
Date: Wed, 06 Dec 2017 15:32:01 +1100
Message-ID: <87374ofpdq.fsf@concordia.ellerman.id.au>
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

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
>
> Print the function address associated with the restore_r2() error to
> make it easier to debug the problem.
>
> Also clarify the wording a bit.
>
> Before:
>
>   module_64: patch_foo: Expect noop after relocate, got 3c820000
>
> After:
>
>   module_64: patch_foo: Expected noop after call, got 7c630034 at netdev_has_upper_dev+0x54/0xb0 [patch_foo]

I renamed noop to nop, as that's the name of the instruction.

cheers
