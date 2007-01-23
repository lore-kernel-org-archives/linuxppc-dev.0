Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 096F0DE01D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Jan 2007 03:33:00 +1100 (EST)
Message-ID: <45B638B5.70901@freescale.com>
Date: Tue, 23 Jan 2007 10:32:53 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
Subject: Re: [MPC8349ITX] USB Init with PPC arch
References: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
In-Reply-To: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Benjamin Zores wrote:
> Hi,
> 
> This question is mainly intended to Freescale's MPC8349ITX board maintainer
> but the issue/resolution is probably the same for other boards.

I'm the maintainer, although I don't think I can help you with this specific 
problem.

> I'm trying to boot the MPC8349ITX card with Linux 2.6.19 using old PPC
> architecture (and not the new PowerPC one).
> I've ported patches from Freescale's BSP from 2.6.13 to 2.6.19 and
> it works pretty well but USB doesn't init properly.
> 
> Switching to PowerPC arch of course works fine and USB is well inited
> but due to other feature i use that only exist on PPC right now, I can't
> make use of it.

What feature is that?  I would think it would be easier to port that feature to 
the powerpc architecture, then it would be to port ITX support to the ppc 
architecture.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
