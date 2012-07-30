Return-Path: <B37400@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 991942C007D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 19:29:24 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: John Stoffel <john@stoffel.org>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Mon, 30 Jul 2012 09:29:15 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511095@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20498.41365.853741.261834@quad.stoffel.home>
In-Reply-To: <20498.41365.853741.261834@quad.stoffel.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----Original Message-----
From: John Stoffel [mailto:john@stoffel.org]=20
Sent: 27 July 2012 19:42
To: Singh Sandeep-B37400
Cc: linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org; ga=
lak@kernel.crashing.org; linux-kernel@vger.kernel.org; devel@driverdev.osuo=
sl.org
Subject: Re: [2/3][PATCH][v2] TDM Framework


> From: Sandeep Singh <Sandeep@freescale.com> TDM Framework is an=20
> attempt to provide a platform independent layer which can offer a=20
> standard interface  for TDM access to different client modules.

Please don't use TLAs (Three Letter Acronyms) like TDM without explaining t=
he clearly and up front.  It makes it hard for anyone else who doens't know=
 your code to look it over without having to spend lots of time poking arou=
nd to figure it out from either context or somewhere else.
[Sandeep] Patch for documentation for TDM is present in this patch set, whi=
ch explains TDM in detail. Should we do this in commit message too??
Link too documentation patch: http://patchwork.ozlabs.org/patch/173680/

John
