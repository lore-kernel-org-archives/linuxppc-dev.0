Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E2553DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Feb 2007 00:10:01 +1100 (EST)
Date: Wed, 14 Feb 2007 16:10:37 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: Moving from arch/ppc to arch/powerpc with an MPC8248 (part 1)
Message-ID: <20070214161037.16260438@vitb.dev.rtsoft.ru>
In-Reply-To: <200702141308.17815.laurent.pinchart@technotrade.biz>
References: <200702141308.17815.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 14 Feb 2007 13:08:17 +0100
Laurent Pinchart <laurent.pinchart@technotrade.biz> wrote:

> Hi everybody,
> 
> I'm trying to take the big jump and move my (mostly) stable board support from 
> arch/ppc to arch/powerpc. I'm still at a very early stage, but here are 
> already a few questions.
> 
> arch/ppc defines some 8260 generic handlers in syslib/mpc8260_setup.c for 
> operations such as halt, reset, show_cpuinfo, ... The MPC82xx ADS in 
> arch/powerpc/platforms/82xx redefines those handles as board-specific 
> functions. Should they be made generic to all 82xx boards, or should I copy 
> them to my board-specific file ? If the code should be shared by all 82xx 
> boards, I'll probably end up copying most of the 
> arch/ppc/syslib/mpc8260_setup.c code to 
> arch/powerpc/platforms/82xx/mpc82xx.c.
> 
I'd just copy stuff to the BSP -- let's consider the common/uncommon stuff later when we'll have to add something else.

It's hard to envision what level of code should be common and what should be board-specific as of now.
Otherwise, we'll have to painfully revisit issue later.

-- 
Sincerely, 
Vitaly
