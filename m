Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: SMT priority (PPR) save and restore
In-reply-to: <14399.1342994689@neuling.org>
References: <1342259024.11305.38.camel@hbabu-laptop>
 <31198.1342410079@neuling.org> <1342863499.28370.41.camel@hbabu-laptop>
 <14399.1342994689@neuling.org>
Date: Mon, 23 Jul 2012 09:57:44 +1000
Message-ID: <23815.1343001464@neuling.org>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > > Can you break this patch into a few parts that are easier to review than
> > > one giant patch.  Start by adding the PPR ftr bits, then the extra space
> > > in the paca, then the new macros, then use the new infrastructure.  I'm
> > > sure you can get 5 or so patches which will be much easier to review.
> > > 
> > > Also this has been white space munged.  See here:
> > >   http://patchwork.ozlabs.org/patch/170993/
> > > All the #defines are broken.
> > > 
> > > Also, do you know what the impacts of this are on null syscall/page
> > > faults etc on machines which need the PPR switched?  If it's big, we
> > > might want to have this as a CONFIG option for those who don't care and
> > > want the speed bump.
> > 
> > Thanks for your comments. Sure will split this patch in to 5/6 patches. 
> > With Anton's num_syscall test  -
> > http://ozlabs.org/~anton/junkcode/null_syscall.c, noticed 6% overhead.
> > As you suggested, will add CONFIG option for this feature. 
> 
> Eek.. 6%.. yes, definitely a CONFIG option then.

... maybe even a boot time option so we can turn it on and off easily
for distros.

Mikey
