Return-Path: <av1474@comtv.ru>
Received: from akado.ru (fe01x03-cgp.akado.ru [77.232.31.164])
 by ozlabs.org (Postfix) with ESMTP id AC1362C007D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2012 07:05:26 +1000 (EST)
Date: Sat, 22 Sep 2012 00:05:08 +0400 (MSK)
From: malc <av1474@comtv.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: Probing for native availability of isel from userspace
Message-ID: <alpine.LNX.2.00.1209212355050.8539@linmac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: hollis@penguinppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Is it possible to determine if _native_ isel is available from userspace 
somehow? So far my searches on the web and within kernel (headers)/glibc
were fruitless (aux vectors, cpu_user_features), few people people (Hollis
Blanchard, Richard Henderson) suggested PPC_FEATURE_ARCH_2_06, but
PowerISA_V2.06B_V2_PUBLIC.pdf says - "3.3.11 Fixed-Point Select [Category: 
Phased-In (sV2.06)]" about isel, the sV2.06 (s part) means something i
suppose, furthermore Hollis mentioned that some pre 2.06 cores came with
isel.

Thanks.

-- 
mailto:av1474@comtv.ru
