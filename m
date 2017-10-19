Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHbzF0BC2zDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:48:25 +1100 (AEDT)
In-Reply-To: <1507646852-18642-1-git-send-email-kamalesh@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: powerpc/modules: Use WARN_ON() in stub_for_addr()
Message-Id: <3yHbzD5Y2kz9tXF@ozlabs.org>
Date: Thu, 19 Oct 2017 15:48:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-10 at 14:47:32 UTC, Kamalesh Babulal wrote:
> Use WARN_ON(), while running out of stubs in stub_for_addr()
> and abort loading of the module instead of BUG_ON().
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1c0437af9fca8de6e4ba179d18cf13

cheers
