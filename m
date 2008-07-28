Return-Path: <paul.gortmaker@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id C69E6DE49C
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 05:05:12 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so422654qwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 12:05:10 -0700 (PDT)
Message-ID: <7d1d9c250807281205j5f9a8dc4h878dd77eb6d6e816@mail.gmail.com>
Date: Mon, 28 Jul 2008 15:05:10 -0400
From: "Paul Gortmaker" <paul.gortmaker@gmail.com>
To: "mike zheng" <mail4mz@gmail.com>
Subject: Re: MPC8323RDB BSP on Kernel2.4
In-Reply-To: <5c9cd53b0807281144y72c0bb2bre69db29288c8e5a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5c9cd53b0807281144y72c0bb2bre69db29288c8e5a8@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 28, 2008 at 2:44 PM, mike zheng <mail4mz@gmail.com> wrote:
> Hi All,
>
> Is the any MPC8323RDB BSP on Kernel 2.4? I have the BSP on Kernel 2.6
> provided by Freescale. Unfortunate we are using Kernel2.4. Is there
> any exist BSP of this board on Kernel2.4? Or a BSP of similar board on
> Kernel2.4?

Generally speaking, most of these more modern eval boards from
Freescale have been supported only since post 2.6.15 or so, and as
such are implemented as arch/powerpc and not the older/obsolete
arch/ppc (as what was used in 2.4).   Trying to graft them onto a
2.4 kernel sounds like a lot of wasted cycles to me.  You may have
to revisit your reasoning for requiring a 2.4 kernel.

Paul.

>
> Thanks in advance,
>
> Mike
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
