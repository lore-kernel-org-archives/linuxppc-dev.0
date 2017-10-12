Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCBLz3yq4zDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 11:20:11 +1100 (AEDT)
In-Reply-To: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: powerpc/livepatch: Fix livepatch stack access
Message-Id: <3yCBLz3FhBz9t2W@ozlabs.org>
Date: Thu, 12 Oct 2017 11:20:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 10:19:51 UTC, Kamalesh Babulal wrote:
> While running stress test with livepatch module loaded, kernel
> bug was triggered.
...
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/e36a82ee4c514a2f4f8fa30c780ad0

cheers
