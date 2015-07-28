Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E37FC1A0709
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 22:18:48 +1000 (AEST)
Message-ID: <1438085921.2773.1.camel@ellerman.id.au>
Subject: Re: [PATCH 11/11] selftests/seccomp: Add powerpc support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, LKML
 <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will
 Drewry <wad@chromium.org>, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Date: Tue, 28 Jul 2015 22:18:41 +1000
In-Reply-To: <CAGXu5jLQUU5Xov+MQs7YfMEobCyjYLjOcpOZw7JG0wqvVci1yA@mail.gmail.com>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
 <1437646871-3195-11-git-send-email-mpe@ellerman.id.au>
 <CAGXu5jLQUU5Xov+MQs7YfMEobCyjYLjOcpOZw7JG0wqvVci1yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-27 at 11:59 -0700, Kees Cook wrote:
> On Thu, Jul 23, 2015 at 3:21 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Wire up the syscall number and regs so the tests work on powerpc.
> 
> This patch begs the question: this passes everything? 

Doh, yes that would have been worth mentioning! :)

I'll update it before I commit it.

Yes everything passes, thanks very much for the tests BTW.

And for the record I've tested on: ppc64, ppc64 (compat), ppc64le,
ppc, ppc64e and ppc64e (compat).

> (I was reminded about syscall_restart while reading the patches. If
> everything passes, it looks like powerpc exposes syscall_restart? Seems like
> ARM remains the odd-arch-out on this. :P)

Yeah I noticed that and though "oh jeez not syscall_restart", but it seems to
pass, so I guess we behave in a standard fasion for once. I'll have a closer
look just to be sure before I merge.

cheers
