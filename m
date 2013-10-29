Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6912F2C014B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 14:05:50 +1100 (EST)
Message-ID: <1383015939.3410.54.camel@snotra.buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Date: Mon, 28 Oct 2013 22:05:39 -0500
In-Reply-To: <20131029024412.GA25844@home.buserror.net>
References: <20131029024412.GA25844@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-10-28 at 21:44 -0500, Scott Wood wrote:
> Sorry again for the lateness.  I tried to get this done before the
> conferences last week, but it just didn't happen.
> 
> Highlights include corenet board file consolidation, the ability to run
> userspaces with lwsync on e500v1/v2, some cleanup patches that other KVM
> patches will build on, support for stripped-down e6500 emulation targets,
> and some fixes of minor longstanding issues.
> 
> Some of the more complicated and/or more recently posted patches didn't
> make it this time around; this doesn't mean I've forgotten them (as long
> as they're in patchwork in an action required state), just that I've run
> out of time for 3.13.
> 
> The following changes since commit 3ad26e5c4459d3793ad65bc8929037c70515df83:
> 
>   Merge branch 'for-kvm' into next (2013-10-11 18:23:53 +1100)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to b60c5a7a82cdfec2221263ce259faa4a36696163:
> 
>   powerpc/6xx: CONFIG_MCU_MPC8349EMITX cannot be a module (2013-10-28 21:11:24 -0500)

Sigh, I just saw Kumar's e-mail about the build breakage with
CONFIG_PPC_EMULATED_STATS (I got dropped from the CC list at some
point).  CONFIG_PPC_EMULATED_STATS should probably be enabled by
default, and by default print the first emulation of each type rather
than just using printk_ratelimited().  I'll send a fix for the build
breakage.

-Scott
