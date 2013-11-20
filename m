Return-Path: <scottwood@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46A602C0099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 03:57:30 +1100 (EST)
Message-ID: <1384966640.1403.421.camel@snotra.buserror.net>
Subject: Re: BUG: Patch "Convert some mftb/mftbu into mfspr" breaks MPC885
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Wed, 20 Nov 2013 10:57:20 -0600
In-Reply-To: <528C82D1.4090803@c-s.fr>
References: <528C82D1.4090803@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 10:37 +0100, leroy christophe wrote:
> Scott,
> 
> The patch "Convert some mftb/mftbu into
> mfspr" (beb2dc0a7a84be003ce54e98b95d65cc66e6e536) breaks startup on
> MPC885.
> 
> The CPU traps (SoftwareEmulation trap) at sched_clock() when trying to
> read TBU with mfspr.
> 
> Reverting the patch solves the issue.
> 
> What's the prefered way to fix this ?

I guess we need to add an ifdef.

-Scott
