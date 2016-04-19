Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qq12v3QtrzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 20:09:43 +1000 (AEST)
In-Reply-To: <20160415120724.40180a50@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: [2/3] powerpc: Update cpu_user_features2 in scan_features()
Message-Id: <3qq12t0fypz9t8g@ozlabs.org>
Date: Tue, 19 Apr 2016 20:09:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-15-04 at 02:07:24 UTC, Unknown sender due to SPF wrote:
> scan_features() updates cpu_user_features but not cpu_user_features2.
> 
> Amongst other things, cpu_user_features2 contains the user TM feature
> bits which we must keep in sync with the kernel TM feature bit.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/beff82374b259d726e2625ec6c

cheers
