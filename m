Return-Path: <timur.tabi@gmail.com>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170]) by ozlabs.org (Postfix) with ESMTP id 6E522B7D20
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 21:39:32 +1000 (EST)
Received: by pxi18 with SMTP id 18so2370659pxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 05 May 2010 04:39:31 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20100505112208.GD5754@opensource.wolfsonmicro.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
	<20100505112208.GD5754@opensource.wolfsonmicro.com>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 5 May 2010 06:39:01 -0500
Message-ID: <g2ied82fe3e1005050439v70066822h7518ac53f97e97f6@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc/8610: add probing for individual
	DMA channels, not just DMA controllers
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 5, 2010 at 6:22 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Just looking at the scheduling here with regard to the merge window and
> the fact that this doesn't seem to hurt the existing drivers perhaps it
> makes sense to merge this via the PowerPC tree immediately?

Aren't we a little late in the cycle for a patch that doesn't do anything?

I was expecting this patch to go into Liam's tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
