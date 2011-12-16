Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7F7B11007D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2011 04:59:44 +1100 (EST)
Message-ID: <4EEB8704.8030201@freescale.com>
Date: Fri, 16 Dec 2011 11:59:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: LiuShuo <b35362@freescale.com>
Subject: Re: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
References: <1322973098-2528-1-git-send-email-shuo.liu@freescale.com>
 <1322973098-2528-3-git-send-email-shuo.liu@freescale.com>
 <4EDEAEB9.6020703@freescale.com> <1323724195.2297.11.camel@koala>
 <4EE66EFE.1050608@freescale.com> <1323724784.2297.20.camel@koala>
 <4EE6725C.3050706@freescale.com> <4EE6BC9B.4000602@freescale.com>
 <4EE8612C.9050104@freescale.com> <4EE903CE.1010903@freescale.com>
 <4EEAB076.30000@freescale.com>
In-Reply-To: <4EEAB076.30000@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Artem.Bityutskiy@nokia.com, dedekind1@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 shuo.liu@freescale.com, linux-mtd@lists.infradead.org,
 akpm@linux-foundation.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/15/2011 08:44 PM, LiuShuo wrote:
> hi Artem,
> Could this patch be applied now and we make a independent patch for  bad
> block information
> migration later?

This patch is not safe to use without migration.

-Scott
