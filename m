Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 818A5DDE00
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 07:42:34 +1100 (EST)
Date: Wed, 14 Feb 2007 21:42:33 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: Moving from arch/ppc to arch/powerpc with an MPC8248 (part 1)
In-Reply-To: <200702141308.17815.laurent.pinchart@technotrade.biz>
Message-ID: <Pine.LNX.4.60.0702142138460.8621@poirot.grange>
References: <200702141308.17815.laurent.pinchart@technotrade.biz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Wed, 14 Feb 2007, Laurent Pinchart wrote:

> arch/ppc defines some 8260 generic handlers in syslib/mpc8260_setup.c for 
> operations such as halt, reset, show_cpuinfo, ... The MPC82xx ADS in 
> arch/powerpc/platforms/82xx redefines those handles as board-specific 
> functions. Should they be made generic to all 82xx boards, or should I copy 
> them to my board-specific file ? If the code should be shared by all 82xx 
> boards, I'll probably end up copying most of the 
> arch/ppc/syslib/mpc8260_setup.c code to 
> arch/powerpc/platforms/82xx/mpc82xx.c.

Emn, sorry, don't know about 8248 and 8260 specifically, but just looking 
at notation 8248 should be closer to 8245 than to 8260, is it not?

If there are enough similarities, you might also look at 
arch/powerpc/platforms/embedded6xx/linkstation.c for an example of such a 
ppc -> powerpc migration. Not that I considered it an ideal example to 
follow. Rather, if it helps you - good. If you find anything that can be 
improved there - would be happy to know.

Thanks
Guennadi
---
Guennadi Liakhovetski
