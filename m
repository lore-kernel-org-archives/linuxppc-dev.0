Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3BHK4prkzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 03:48:45 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id o123so6727069pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:48:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/3] cpufeatures merge candidate
Date: Thu, 13 Apr 2017 03:48:29 +1000
Message-Id: <20170412174833.5924-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I expect this will require still some more changes, but I think it's
getting close to polished. Intention is to make it default off and
unsupported at the initial merge, to give a new more weeks to test
then freeze the format.

I included the firmware cpufeatures patch here as well.

Thanks,
Nick
