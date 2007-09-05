Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E4C6FDDF2F
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:12:34 +1000 (EST)
Date: Wed, 5 Sep 2007 21:12:30 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] Add 6xx-style HID0_SLEEP support.
In-Reply-To: <20070712191304.GC31381@ld0162-tx32.am.freescale.net>
Message-ID: <Pine.LNX.4.60.0709052015490.5113@poirot.grange>
References: <20070712191304.GC31381@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 12 Jul 2007, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/sysdev/6xx-pm.S |   52 ++++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/sysdev/Makefile |    4 +++
>  include/asm-powerpc/mpc6xx.h |    6 +++++
>  3 files changed, 62 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/6xx-pm.S
>  create mode 100644 include/asm-powerpc/mpc6xx.h

Hi Scott

has this patch (series) been pushed in any upstream tree? Don't see it in 
the current powerpc.git nor in -mm. If I'm right and it's not upstream 
yet, Paul, what are the plans wrt these patches?

Thanks
Guennadi
---
Guennadi Liakhovetski
