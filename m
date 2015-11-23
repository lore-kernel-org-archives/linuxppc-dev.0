Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D9061A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 14:29:53 +1100 (AEDT)
Message-ID: <1448249392.18775.12.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Standardise on NR_syscalls rather than
 __NR_syscalls.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>, Rashmica Gupta <rashmicy@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 23 Nov 2015 14:29:52 +1100
In-Reply-To: <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
References: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
 <CAOJe8K0yHTdymRbEo=itvK-AYiNzQLLspNgTyyzADkzpPxpzHw@mail.gmail.com>
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

On Thu, 2015-11-19 at 12:15 +0300, Denis Kirjanov wrote:

> On 11/19/15, Rashmica Gupta <rashmicy@gmail.com> wrote:

> > Most architectures use NR_syscalls as the #define for the number of
> > syscalls.
> > 
> > We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
> > 
> > __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
> > NR_syscalls must be defined and __NR_syscalls does not, replace
> > __NR_syscalls with NR_syscalls.
>
> Hi,
> 
> But what's wrong with the current code? Why do we need such change?

The change log explains it fairly well I think. Which part is not clear?

cheers
