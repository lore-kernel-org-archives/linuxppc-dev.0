Return-Path: <B34182@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8C248B7046
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 13:53:54 +1100 (EST)
Subject: Re: [PATCH] powerpc/srio: Fix the compile errors when building
 with 64bit
From: Liu Gang <Gang.Liu@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <4F50D98F.1040705@windriver.com>
References: <1330672127-22172-1-git-send-email-Gang.Liu@freescale.com>
 <4F50D98F.1040705@windriver.com>
Content-Type: text/plain
Date: Mon, 5 Mar 2012 10:52:24 +0800
Message-ID: <1330915944.23420.115.camel@10.ap.freescale.net>
MIME-Version: 1.0
Cc: r58472@freescale.com, linux-kernel@vger.kernel.org, r61911@freescale.com,
 Alexandre.Bounine@idt.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, Paul,

On Fri, 2012-03-02 at 09:30 -0500, Paul Gortmaker wrote:
> > Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> Hi Liu,
> 
> You can't just go adding a "Signed-off-by:" line for me to a patch that
> I've never seen before.  Perhaps you meant to add "Reported-by:" ?
> 
> Paul.

I'm sorry for this. I added "Signed-off-by" for you because I wanted to
thank you found this issue. I'll add "Reported-by:" if needed in the
future.

Best Regards,

Liu Gang
