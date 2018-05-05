Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40dL5y3tPWzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 17:26:13 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id q22so19101826pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 May 2018 00:26:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 0/2] powerpc/watchdog: provide more data in watchdog
 messages
Date: Sat,  5 May 2018 17:25:58 +1000
Message-Id: <20180505072600.13270-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since v1, Balbir's feedback:
- Split into two patches
- Added human-readable intervals as well as TB timestamps.

Nicholas Piggin (2):
  powerpc/watchdog: don't update the watchdog timestamp if a lockup is
    detected
  powerpc/watchdog: provide more data in watchdog messages

 arch/powerpc/kernel/watchdog.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.17.0
