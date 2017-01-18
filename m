Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3Qlk35bRzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 23:10:26 +1100 (AEDT)
In-Reply-To: <1482149813-24652-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: selftest/powerpc: Wrong PMC initialized in pmc56_overflow test
Message-Id: <3v3Qlk18TQz9sf9@ozlabs.org>
Date: Wed, 18 Jan 2017 23:10:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-12-19 at 12:16:53 UTC, Madhavan Srinivasan wrote:
> Test uses PMC2 to count the event. But PMC1 is being initialized.
> Patch to fix it.
> 
> Fixes: 3752e453f6ba ('selftests/powerpc: Add tests of PMU EBBs')
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/df21d2fa733035e4d414379960f94b

cheers
