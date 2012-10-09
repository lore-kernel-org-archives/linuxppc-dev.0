Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 576A62C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 07:00:05 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/3] rapidio: updates for multiple mport patches
Date: Tue,  9 Oct 2012 15:57:53 -0400
Message-Id: <1349812676-27057-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a set of updates for patches submitted earlier:
https://lkml.org/lkml/2012/10/3/460.

Alexandre Bounine (3):
  rapidio: use msleep in discovery wait
  rapidio: update asynchronous discovery initialization
  rapidio: update for destination ID allocation

 drivers/rapidio/rio-scan.c |   40 ++++++++++-------------
 drivers/rapidio/rio.c      |   75 +++++++++++++++++++++++++++----------------
 include/linux/rio.h        |    1 -
 3 files changed, 64 insertions(+), 52 deletions(-)

-- 
1.7.8.4
