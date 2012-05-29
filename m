Return-Path: <ppc@mindchasers.com>
Received: from vms173015pub.verizon.net (vms173015pub.verizon.net
 [206.46.173.15]) by ozlabs.org (Postfix) with ESMTP id 2A7AAB6FAC
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 05:13:59 +1000 (EST)
Received: from [192.168.1.41] ([unknown] [108.25.140.29])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M4S00HFBQMBLX70@vms173015.mailsrvcs.net> for
 linuxppc-dev@ozlabs.org; Tue, 29 May 2012 13:13:28 -0500 (CDT)
Message-id: <4FC511C1.4050007@mindchasers.com>
Date: Tue, 29 May 2012 14:13:21 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MSR loses DE bit in 3.3, BDI2000 cant handle breakpoints?
References: <OF00FC5182.FED0E75C-ONC1257A0D.003AA532-C1257A0D.0041F687@transmode.se>
In-reply-to: <OF00FC5182.FED0E75C-ONC1257A0D.003AA532-C1257A0D.0041F687@transmode.se>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2012 08:00 AM, Joakim Tjernlund wrote:
>
> I cannot make simple break points using BDI2000 work in 3.3, abatro suggests that it
> depends on MSR[DE] is cleared by the kernel. With the emulator I can see that
> MSR[DE] is off quite often by just stopping at random times and looking at MSR so
> it seems like the kernel is turning MSR[DE] off most of the time.
> Anyone else having success debugging 3.3 with BDI2000?
>
> This is on a P2010(E500/BOOKE) CPU.
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

I debug using Freescale CodeWarrior and a USB tap, which also rely on 
MSR[DE] being set.  I develop from the mainline & have a patch set that 
I just recently re-tweaked to support kernel debugging.

If you want, I'll send you my set of patches for the kernel.  They might 
be useful (not sure since I don't use BDI).
