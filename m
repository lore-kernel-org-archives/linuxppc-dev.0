Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP3B63JJMzDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:31:10 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id i63so4660060pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 12:31:10 -0700 (PDT)
Date: Fri, 12 May 2017 05:30:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, Scott Wood <oss@buserror.net>
Subject: Re: [PATCH 3/3] powerpc/8xx: xmon compile fix
Message-ID: <20170512053052.0e9344a6@roar.ozlabs.ibm.com>
In-Reply-To: <fdb9e787-e397-a46e-467c-066d51d73131@c-s.fr>
References: <20170511151522.4772-1-npiggin@gmail.com>
 <20170511151522.4772-3-npiggin@gmail.com>
 <b84f2d89-fc2f-d25f-1871-8fcd7b133fcf@c-s.fr>
 <fdb9e787-e397-a46e-467c-066d51d73131@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 May 2017 20:52:56 +0200
christophe leroy <christophe.leroy@c-s.fr> wrote:

> Le 11/05/2017 à 19:14, christophe leroy a écrit :
> >
> >
> > Le 11/05/2017 à 17:15, Nicholas Piggin a écrit :  
> >> Cc: Scott Wood <oss@buserror.net>
> >> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  arch/powerpc/xmon/xmon.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> >> index f11f65634aab..ec420b0e6e88 100644
> >> --- a/arch/powerpc/xmon/xmon.c
> >> +++ b/arch/powerpc/xmon/xmon.c
> >> @@ -1242,10 +1242,13 @@ bpt_cmds(void)
> >>  {
> >>      int cmd;
> >>      unsigned long a;
> >> -    int mode, i;
> >> +    int i;
> >>      struct bpt *bp;
> >> +#ifndef CONFIG_8xx  
> >
> > Would be better to use CONFIG_PPC_8xx
> >
> > As stated in arch/powerpc/platform/Kconfig.cputype, CONFIG_8xx is temp
> > to handle compat with arch/ppc, and we are trying to get rid of it  
> 
> I had the same comment in https://patchwork.ozlabs.org/patch/700354/
> I also suggested to move the relevant declarations inside the switch()

Apologies, you did. I was just cleaning out an old backlog of
patches and I forgot about your comments. Sorry, I'll resend
the patch.

Thanks,
Nick
