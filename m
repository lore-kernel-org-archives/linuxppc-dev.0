Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcSX838V7zDqFJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 19:11:20 +1000 (AEST)
In-Reply-To: <20170512104707.5393eaa1@roar.ozlabs.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>,
 christophe leroy <christophe.leroy@c-s.fr>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] powerpc/8xx: xmon compile fix
Message-Id: <3wcSX82gZbz9s7M@ozlabs.org>
Date: Tue, 30 May 2017 19:11:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-05-12 at 00:47:07 UTC, Nicholas Piggin wrote:
> On Thu, 11 May 2017 20:52:56 +0200
> christophe leroy <christophe.leroy@c-s.fr> wrote:
> 
> > Le 11/05/2017 à 19:14, christophe leroy a écrit :
> > >
> > >
> > > Le 11/05/2017 à 17:15, Nicholas Piggin a écrit :  
> > >> Cc: Scott Wood <oss@buserror.net>
> > >> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > >> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > >> ---
> > >>  arch/powerpc/xmon/xmon.c | 5 ++++-
> > >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > >> index f11f65634aab..ec420b0e6e88 100644
> > >> --- a/arch/powerpc/xmon/xmon.c
> > >> +++ b/arch/powerpc/xmon/xmon.c
> > >> @@ -1242,10 +1242,13 @@ bpt_cmds(void)
> > >>  {
> > >>      int cmd;
> > >>      unsigned long a;
> > >> -    int mode, i;
> > >> +    int i;
> > >>      struct bpt *bp;
> > >> +#ifndef CONFIG_8xx  
> > >
> > > Would be better to use CONFIG_PPC_8xx
> > >
> > > As stated in arch/powerpc/platform/Kconfig.cputype, CONFIG_8xx is temp
> > > to handle compat with arch/ppc, and we are trying to get rid of it  
> > 
> > I had the same comment in https://patchwork.ozlabs.org/patch/700354/
> > I also suggested to move the relevant declarations inside the switch()

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/09b6c1129f899c72d70b8bea360206

cheers
