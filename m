Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0010.hostedemail.com
 [216.40.44.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2rM62QJZzDvgd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 09:20:17 +1100 (AEDT)
Message-ID: <1477347610.2111.6.camel@perches.com>
Subject: Re: [PATCH] powerpc/pseries: fix spelling mistake: "Attemping" ->
 "Attempting"
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Colin King <colin.king@canonical.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Rashmica Gupta <rashmicy@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>
Date: Mon, 24 Oct 2016 15:20:10 -0700
In-Reply-To: <CAGXu5j+RGsCwZ4SpnZKnoqt3zsyYPW8FdZ8vS7cRwr_L+0q2fA@mail.gmail.com>
References: <20161024220212.8464-1-colin.king@canonical.com>
 <CAGXu5j+RGsCwZ4SpnZKnoqt3zsyYPW8FdZ8vS7cRwr_L+0q2fA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-10-24 at 15:13 -0700, Kees Cook wrote:
> On Mon, Oct 24, 2016 at 3:02 PM, Colin King <colin.king@canonical.com> wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > trivial fix to spelling mistake in pr_debug message
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  arch/powerpc/platforms/pseries/hotplug-cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > index a1b63e0..c8929cb 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> > @@ -553,7 +553,7 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
> >  {
> >         int rc;
> > 
> > -       pr_debug("Attemping to remove CPU %s, drc index: %x\n",
> > +       pr_debug("Attempting to remove CPU %s, drc index: %x\n",
> >                  dn->name, drc_index);
> > 
> >         rc = dlpar_offline_cpu(dn);
> > --
> > 2.9.3
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> scripts/spelling.txt should likely get an addition for "attemping". It
> already has "attemps"...

There may not be enough of these to be useful and to my
knowledge Colin isn't fixing comments

$ grep -rP --include=*.[ch] -wi "at+emp*t?ing" * | grep -vi attempting
arch/x86/platform/uv/uv_nmi.c:/* Ping non-responding cpus attemping to force them into the NMI handler */
arch/powerpc/platforms/pseries/hotplug-cpu.c:	pr_debug("Attemping to remove CPU %s, drc index: %x\n",
