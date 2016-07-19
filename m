Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvDKX57s2zDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 07:52:16 +1000 (AEST)
Message-ID: <1468965129.25630.15.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 19 Jul 2016 16:52:09 -0500
In-Reply-To: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
References: <CAPk1OjHu7SZ_eOrUx5MQGBTenKAQCUENFeYWVyqWoemqnvo7eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Suspected regression?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-19 at 12:00 +0200, Alessio Igor Bogani wrote:
> Hi all,
> 
> I have got two boards MVME5100 (MPC7410 cpu) and MVME7100 (MPC8641D
> cpu) for which I use the same cross-compiler (ppc7400).
> 
> I tested these against kernel HEAD to found that these don't boot
> anymore (PID 1 crash).
> 
> Bisecting results in first offending commit:
> 7aef4136566b0539a1a98391181e188905e33401
> 
> Removing it from HEAD make boards boot properly again.
> 
> A third system based on P2010 isn't affected at all.
> 
> Is it a regression or I have made something wrong?

I booted both my next branch, and Linus's master on MPC8641HPCN and didn't see
this -- though possibly your RFS is doing something different.  Maybe that's
the difference with P2010 as well.

Is there any way you can debug the cause of the crash?  Or send me a minimal
RFS that demonstrates the problem (ideally with debug symbols on the userspace
binaries)?

-Scott
