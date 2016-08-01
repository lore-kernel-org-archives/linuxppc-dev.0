Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3F2455CdzDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 08:51:40 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: MPC5200 does not boot
Date: Tue, 02 Aug 2016 00:44:32 +0200
Message-ID: <874m74w1m7.fsf@steelpick.2x.cz>
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

Hi Benjamin,

the following commit causes my MPC5200 not to boot.

    commit 9402c684613163888714df0955fa1f17142b08bf
    Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Date:   Tue Jul 5 15:03:41 2016 +1000
     
        powerpc: Factor do_feature_fixup calls
        
        32 and 64-bit do a similar set of calls early on, we move it all to
        a single common function to make the boot code more readable.
        
        Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
        Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

I suspect that the cause will be similar as described in commit
1cd03890ea64795e53f17a94928cca22495acb2a. Unfortunately, I don't have
much time to debug this, but I can easily test patches.

Best regards,
-Michal
