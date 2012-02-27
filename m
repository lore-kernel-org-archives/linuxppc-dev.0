Return-Path: <B34182@freescale.com>
Received: from VA3EHSOBE002.bigfish.com (va3ehsobe002.messaging.microsoft.com
 [216.32.180.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF5A9B6FC3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2012 17:50:01 +1100 (EST)
Subject: Re: [PATCH/RFC] rapidio: temporarily exclude FSL_RIO from 64 bit
 builds
From: Liu Gang <Gang.Liu@freescale.com>
To: Paul Gortmaker <paul.gortmaker@gmail.com>
In-Reply-To: <CAP=VYLroaEKncpy7VBobJdXijnDS5UdTV7qPG2A--SicnGvFSg@mail.gmail.com>
References: <1329865853-17277-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLroaEKncpy7VBobJdXijnDS5UdTV7qPG2A--SicnGvFSg@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 27 Feb 2012 14:48:48 +0800
Message-ID: <1330325328.23420.93.camel@10.ap.freescale.net>
MIME-Version: 1.0
Cc: Alexandre.Bounine@idt.com, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sun, 2012-02-26 at 20:26 -0500, Paul Gortmaker wrote:
> Hi Ben,
> 
> Given a week has passed with the absence of any feedback
> with respect to SRIO on 64 bit, are you OK with applying the
> below patch[1] pretty much as-is?

Hi, Paul, Ben,

Sorry for the late reply because of my other urgent issues. I also found
these errors of 64bit building last week. I'll provide patch for this
issue as soon as possible.

Thanks.

Best Regards,

Liu Gang
