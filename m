Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0E0C2C02C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 00:57:16 +1000 (EST)
Message-ID: <4FFD9439.2010901@freescale.com>
Date: Wed, 11 Jul 2012 09:56:57 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
 <CAOZdJXX1+=p3GMccLvCwFpei2igidXuo_U1gSVy56cBAkKxoHg@mail.gmail.com>
 <4D91E39B-2773-429D-B956-38C04521C8B2@kernel.crashing.org>
 <4FFD9281.1070202@freescale.com>
 <21405BDD-2124-4CB6-A947-0B8124D51063@kernel.crashing.org>
In-Reply-To: <21405BDD-2124-4CB6-A947-0B8124D51063@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: McClintock Matthew-B29882 <B29882@freescale.com>,
 Xu Jiucheng-B37781 <B37781@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> No, I think we should have at least one or two examples of AMP dts in upstream.

We have more than that:

./p2020rdb_camp_core1.dts
./p1020rdb-pc_camp_core1.dts
./mpc8572ds_camp_core1.dts
./p2020rdb_camp_core0.dts
./p1020rdb-pc_camp_core0.dts
./mpc8572ds_camp_core0.dts
./p1020rdb_camp_core1.dts
./p1020rdb_camp_core0.dts


-- 
Timur Tabi
Linux kernel developer at Freescale
