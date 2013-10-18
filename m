Return-Path: <tommusta@gmail.com>
Received: from mail-ob0-x232.google.com (mail-ob0-x232.google.com
 [IPv6:2607:f8b0:4003:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 728D72C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 04:04:30 +1100 (EST)
Received: by mail-ob0-f178.google.com with SMTP id uz6so3293215obc.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Oct 2013 10:04:26 -0700 (PDT)
Received: from [9.10.80.32] (rchp4.rochester.ibm.com. [129.42.161.36])
 by mx.google.com with ESMTPSA id tz10sm5241775obc.10.2013.10.18.10.04.25
 for <linuxppc-dev@lists.ozlabs.org>
 (version=SSLv3 cipher=RC4-SHA bits=128/128);
 Fri, 18 Oct 2013 10:04:25 -0700 (PDT)
Message-ID: <1382115864.2206.12.camel@tmusta-sc.rchland.ibm.com>
Subject: [PATCH 0/2] powerpc: Alignment Handler Fixes for Little Endian
From: Tom Musta <tommusta@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 18 Oct 2013 12:04:24 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series fixes two bugs in the PowerPC Little Endian alignment
handler.

Tom Musta (2):
  powerpc: Fix Handler of Unaligned Load/Store Strings
  powerpc: Enable Little Endian Alignment Handler for Float Pair
    Instructions

 arch/powerpc/kernel/align.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)
