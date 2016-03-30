Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZhfm5zW0zDsMN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 20:09:36 +1100 (AEDT)
Message-ID: <1459328976.23987.4.camel@ellerman.id.au>
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Thiago Jung Bauermann
 <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 20:09:36 +1100
In-Reply-To: <20160330080459.GB21299@naverao1-tp.in.ibm.com>
References: <3qWbvb0yVwz9sdm@ozlabs.org>
 <1459195592-6559-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1459222294.8173.8.camel@ellerman.id.au> <3337968.FTL1d9fOmu@hactar>
 <20160330080459.GB21299@naverao1-tp.in.ibm.com>
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

On Wed, 2016-03-30 at 13:34 +0530, Naveen N. Rao wrote:
> On 2016/03/29 08:35PM, Thiago Jung Bauermann wrote:
> > Am Dienstag, 29 März 2016, 14:31:34 schrieb Michael Ellerman:
> > > On Mon, 2016-03-28 at 17:06 -0300, Thiago Jung Bauermann wrote:
> > > > With this patch, all vmlinux symbols match /proc/kallsyms and the
> > > > testcase passes.
> > >
> > > Have you tested this on an LE system?
> >
> > No, I was focusing on ppc64 BE.
>
> Which kernel did you use? I don't see this with the latest 4.6.0-rc1.

Yeah I can't reproduce the perf test failure either.

Not sure what's going on?

cheers
