Return-Path: <xiaoxianghua@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id E7583B7D5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 May 2010 04:36:40 +1000 (EST)
Received: by gyd10 with SMTP id 10so2230949gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 05 May 2010 11:36:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <569685F045B85741820D0265E0D2999D019CFE8B@tddhh01.hh.thales-naval.de>
References: <569685F045B85741820D0265E0D2999D019CFE8B@tddhh01.hh.thales-naval.de>
Date: Wed, 5 May 2010 13:36:38 -0500
Message-ID: <q2ke6bf505b1005051136mceda63d6re9295bd7b1f812b3@mail.gmail.com>
Subject: Re: Kernel errors at very early stage
From: Xianghua Xiao <xiaoxianghua@gmail.com>
To: "Dunda, Matthias" <Matthias.Dunda@de.thalesgroup.com>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 5, 2010 at 3:27 AM, Dunda, Matthias
<Matthias.Dunda@de.thalesgroup.com> wrote:
> Hi all-
>
> we've built a custom board with a FSL MPC8568EMDS CPU.
>
> U-Boot works so far - at least it is able to load a Linux kernel and a
> flattened device tree via network and launch the kernel.
>
> I get no output on the serial console from the kernel, so my only chance is
> to read out the __log_buf while in memory with my Abatron BDI 3000 debugger.
>
> The thing is, I cannot break into the code really, because it never stops
> reliable at my break points... :-(
>
> Can anyone of you see a usual suspect in the attached log?
>
> Is there something wrong with the timing, maybe? Maybe a hardware issue?
>
> How can I check this?
>
> Cheers
> Matthias
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
from the log it seems your device tree has issue, also you may want to
turn on verbose debug, turn off preempt, turn off no_hz and see how
far it can go.

if only log_buf is available to get some output, you may want to
increase the buffer size to see more

xianghua
