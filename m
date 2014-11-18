Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 157391A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 21:26:22 +1100 (AEDT)
Message-ID: <1416306379.28359.0.camel@concordia>
Subject: Re: [PATCH] [powerpc] Fix Text randomization
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vineeth Vijayan <vvijayan@mvista.com>
Date: Tue, 18 Nov 2014 21:26:19 +1100
In-Reply-To: <CAOpNGcuL-0SDSwDbExLWqWxwp=0zRtRnx_MUnNEb9ywSFrhh8A@mail.gmail.com>
References: <1415956325-10124-1-git-send-email-vvijayan@mvista.com>
 <1416207214.2826.3.camel@concordia>
 <CAOpNGcuL-0SDSwDbExLWqWxwp=0zRtRnx_MUnNEb9ywSFrhh8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-18 at 12:50 +0530, Vineeth Vijayan wrote:
> On Mon, Nov 17, 2014 at 12:23 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Fri, 2014-11-14 at 14:42 +0530, Vineeth Vijayan wrote:
> >> Now there is no way to disable TEXT randomization on a PPC32/PPC64
> >> machine. Text randomization happens even in the case of "echo 0 >
> >> /proc/sys/kernel/randomize_va_space"
> >>
> >> This happens due to the incorrect definition of ELF_ET_DYN_BASE
> >> at arch/powerpc/include/asm/elf.h
> >>
> >> The function randomize_et_dyn is redundant and is removed.
> >
> > The patch looks OK, but for the change log I was thinking something more like
> > this:
> >
> >
> > powerpc: Use generic PIE randomization
> >
> Ok. Thats better.
> Do you want me to send a new patch with updated change log as mentioned ?
 
No that's OK, I've already merged it.

cheers
