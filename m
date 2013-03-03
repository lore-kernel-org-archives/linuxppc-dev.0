Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 222662C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 16:29:17 +1100 (EST)
Message-ID: <1362288548.2969.13.camel@pasglop>
Subject: Re: Linux kernel 3.x problems on PowerMac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Sun, 03 Mar 2013 16:29:08 +1100
In-Reply-To: <51320F53.9040000@mail.ru>
References: <51320F53.9040000@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2013-03-02 at 15:40 +0100, Phileas Fogg wrote:
> recently i got a PowerMac G5 and installed Debian Linux 2.6.32 on it.
> Everything works so far and Debian boots properly.
> 
> Today i tried to boot Linux 3 on the machine and it doesn't boot.
> The Linux 3 kernel was cross-compiled by me.
> 
> On Linux 3.8.1 it hangs after this line:
> ---
> windfarm: Drive bay control loop started.
> 
> And then i'm getting RCU stall call traces.
> 
> On Linux 3.2 it hangs too but not at the same place.
> It hangs after some SCSI message.
> 
> Have anyone tested Linux 3 kernels on PowerMac G5 recently ?

Hrm, this is odd. I do run pretty much every release on my G5's without
problems... Can you send me your .config and then try with a
g5_defconfig just to see if it makes a difference ?

There *might* have been a problem on those older machines vs. the 64T
address space patches, so maybe try back 3.6 and 3.7 and let me know,
I'm still trying to get the right fix in (I know it breaks PS/3 under
some circumstances).

Cheers,
Ben.
