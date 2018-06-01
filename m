Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y86W1JQYzDrph
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:54:59 +1000 (AEST)
In-Reply-To: <20180525021145.4520-1-bauerman@linux.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [v2,
 1/2] selftests/powerpc: Add ptrace tests for Protection Key registers
Message-Id: <40y86V72r1z9s1b@ozlabs.org>
Date: Sat,  2 Jun 2018 01:54:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-25 at 02:11:44 UTC, Thiago Jung Bauermann wrote:
> This test exercises read and write access to the AMR, IAMR and UAMOR.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1f7256e7dddef49acf9f6c9fe3f935

cheers
