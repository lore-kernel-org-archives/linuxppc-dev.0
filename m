Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnmyV26LmzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 23:02:58 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id a70so23656486pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 06:02:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] powerpc (powernv and pseries) cpuidle driver improvmeents
Date: Wed, 14 Jun 2017 23:02:38 +1000
Message-Id: <20170614130241.19865-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

These are a few small improvements that came from doing an
optimisation pass over powerpc cpu idle paths.

Michael reminded me to cc the cpuidle maintainers. I think he
will take the patches through the powerpc tree, but any suggestion
or ack or nack would be welcome.

Thanks,
Nick

Nicholas Piggin (3):
  cpuidle: powerpc: cpuidle set polling before enabling irqs
  cpuidle: powerpc: read mostly for common globals
  cpuidle: powerpc: no memory barrier after break from idle

 drivers/cpuidle/cpuidle-powernv.c | 25 +++++++++++++++++--------
 drivers/cpuidle/cpuidle-pseries.c | 22 +++++++++++++++-------
 2 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.11.0
