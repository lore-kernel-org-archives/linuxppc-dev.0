Return-Path: <bill4carson@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5C89DB7034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 20:05:13 +1100 (EST)
Received: by ghrr11 with SMTP id r11so4052622ghr.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 01:05:09 -0800 (PST)
From: bill4carson@gmail.com
To: bill4carson@gmail.com
Subject: [PATCH-v1]Copy machine descriptor after probe succeed
Date: Tue, 20 Dec 2011 17:08:46 +0800
Message-Id: <1324372127-8552-1-git-send-email-bill4carson@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>





This patch fix minor issue with machine probe process,
It's much better to copy machine descriptor after probe 
succeed.

arch/powerpc/kernel/setup-common.c |    4 ++--
1 files changed, 2 insertions(+), 2 deletions(-
