Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 52EE4DE9C3
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 05:11:24 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1803421pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 12:11:21 -0700 (PDT)
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Josh Boyer <jwboyer@gmail.com>
To: jyoung5@us.ibm.com
In-Reply-To: <1206987826.9165.15.camel@thinkpadL>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<1206987826.9165.15.camel@thinkpadL>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 14:11:14 -0500
Message-Id: <1206990674.12155.64.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-31 at 13:23 -0500, Jerone Young wrote:
> > > diff --git a/arch/powerpc/kernel/idle_4xx.c b/arch/powerpc/kernel/idle_4xx.c
> > > new file mode 100644
> > > --- /dev/null
> > > +++ b/arch/powerpc/kernel/idle_4xx.c
> > 
> > Can this be added to sysdev/ppc4xx_soc.c instead?
> 
> Probably. Though the other platforms have there power_save code in
> idle_<platform>.S files, as they are in assembly.

No, just two of them do.  Cell, pseries, and pasemi all have them under
the platform directory.

> Also I don't appear to have ppc4xx_soc.c in my source (using
> 2.6.25-rc6).

You're working against a very old tree, relatively speaking.  Use either
my for-2.6.26 branch in my git tree, or the linux-next tree.

josh
