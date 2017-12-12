Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXd6BSgzDrVC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:29 +1100 (AEDT)
In-Reply-To: <20171114092910.20399-4-kamalesh@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v4,3/3] powerpc/modules: Improve restore_r2() error message
Message-Id: <3ywyXc275Mz9t8S@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-11-14 at 09:29:10 UTC, Kamalesh Babulal wrote:
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
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1ea61ea23985c0f15c027e4c0ac022

cheers
