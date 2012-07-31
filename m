Return-Path: <B37400@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C5442C007C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 16:41:51 +1000 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Francois Romieu
 <romieu@fr.zoreil.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Tue, 31 Jul 2012 06:41:41 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E511B93@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727152542.GB1613@electric-eye.fr.zoreil.com>
 <20120730154536.GA3218@sirena.org.uk>
In-Reply-To: <20120730154536.GA3218@sirena.org.uk>
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
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]=20
Sent: Monday, July 30, 2012 9:16 PM
To: Francois Romieu
Cc: Singh Sandeep-B37400; devel@driverdev.osuosl.org; linuxppc-dev@lists.oz=
labs.org; galak@kernel.crashing.org; linux-arm-kernel@lists.infradead.org; =
linux-kernel@vger.kernel.org
Subject: Re: [2/3][PATCH][v2] TDM Framework

On Fri, Jul 27, 2012 at 05:25:42PM +0200, Francois Romieu wrote:

> 2. It would probably make sense to Cc: netdev and serial. There may be
>    some kernel client network integration from the start.

Plus audio, quite a few of the buses mentioned as examples of use cases for=
 the hardware are audio ones.
[Sandeep] Ok
