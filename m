Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 4D67FB6EFF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jun 2010 22:30:23 +1000 (EST)
Message-ID: <4C079F1D.7000707@mlbassoc.com>
Date: Thu, 03 Jun 2010 06:25:01 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Anyone using "PowerPC" little-endian mode?
References: <20100603122012.GA22799@brick.ozlabs.ibm.com>
In-Reply-To: <20100603122012.GA22799@brick.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2010 06:20 AM, Paul Mackerras wrote:
> Currently the kernel supports processes running in little-endian mode
> on machines that have a little-endian mode (as opposed to an endian
> bit in the TLB entry like most embedded PowerPC processors do, which
> is a much better idea).  Little-endian mode comes in two flavours:
> so-called "PowerPC" little-endian mode, which works by swizzling the
> bottom 3 bits of the address, and "true" little-endian mode, which
> actually swaps the order of the bytes read from or written to memory.
> The classic 32-bit processors (603, 604, 750, 74xx, and derivatives)
> implemented PowerPC little-endian mode, and I think some early 64-bit
> processors did also.  POWER6 and POWER7 implement true little-endian
> mode.  POWER4, PPC970 and POWER5 don't implement any little-endian
> mode.
>
> Is anyone actually using little-endian mode processes on processors
> that implement PowerPC little-endian mode?  One of the ways that we
> could make the alignment interrupt handler go faster is by removing
> the code for address swizzling that we have in order to handle PowerPC
> little-endian mode.  If nobody is actually using it, we should
> remove it and make the code simpler and faster.

I don't know about today, but my recollection is that the only
use of little-endian mode on PowerPC was during the early days
attempt to run Windows-NT.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
