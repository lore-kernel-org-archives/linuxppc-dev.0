Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id BD5C5DE067
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 07:57:16 +1000 (EST)
Date: Fri, 27 Apr 2007 16:57:44 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powerpc: fix suspend states again
Message-ID: <20070427215744.GA18006@lixom.net>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
	<1177710883.3565.66.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177710883.3565.66.camel@johannes.berg>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 11:54:43PM +0200, Johannes Berg wrote:
> On Fri, 2007-04-27 at 16:53 -0500, Olof Johansson wrote:
> 
> > > + * GPLv2
> > > + */
> > 
> > A regular GPL copyright blurb isn't that hard to paste in. :-)
> 
> Aw, I just hate cluttering all the files with it :)
>
> > > +#ifdef CONFIG_SPE
> > > +extern void enable_kernel_spe(void);
> > > +#endif
> > 
> > This should be added to asm-powerpc/system.h instead
> 
> and it shouldn't be ifdef'ed either ;)

Nope

> > , and that should
> > be included here since that has the enable_kernel_altivec() and
> > enable_kernel_fp() definitions.
> 
> True. Guess I get to make two new patches.

It already was, I missed it. -ENEEDCOFFEE.


-Olof
