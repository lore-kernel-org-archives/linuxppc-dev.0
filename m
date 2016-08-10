Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8SWr0lN4zDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 20:47:04 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s8SWq49Qjz9t0m
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 20:47:02 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id y134so2664313pfg.3
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2016 03:47:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [RFC][PATCH 0/2] powerpc/pseries machine check reentrancy fixes
Date: Wed, 10 Aug 2016 20:46:43 +1000
Message-Id: <1470826005-14520-1-git-send-email-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I noticed a couple of potential issues with MCE handling. I
haven't been able to test this yet, but I would like to get
some second opinions on it. I know a few people have been looking
at the MCE handler recently.

Thanks,
Nick
