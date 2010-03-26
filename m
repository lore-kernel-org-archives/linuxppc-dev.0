Return-Path: <amit.shah@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DC65BB7CFD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 23:53:16 +1100 (EST)
Date: Fri, 26 Mar 2010 18:19:01 +0530
From: Amit Shah <amit.shah@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/7] hvc_console: Fix race between hvc_close and hvc_remove
Message-ID: <20100326124901.GC7039@amit-x200.redhat.com>
References: <20100319151326.GC8541@kroah.com>
	<1269011916-8836-4-git-send-email-gregkh@suse.de>
	<1269119079.8599.65.camel@pasglop>
	<20100321043725.GA21566@amit-x200.redhat.com>
	<20100324121902.GJ15789@amit-x200.redhat.com>
	<4BAC7AD4.4030309@in.ibm.com>
	<20100326095821.GA7039@amit-x200.redhat.com>
	<4BAC9D9E.5070901@in.ibm.com>
	<20100326115233.30288d3c@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100326115233.30288d3c@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, a.p.zijlstra@chello.nl,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, tglx@linutronix.de,
	Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (Fri) Mar 26 2010 [11:52:33], Alan Cox wrote:
> > >> mount: can't find /root/proc in /etc/fstab or /etc/mtab
> > >> /sbin/smart_agetty: can not determine 'console' speed
> > >>     
> > >
> > > OK, this gets even murkier. I don't know why taking a few krefs modifies
> > > hvc_console behaviour to such an extent.
> 
> Can you see if the agetty is getting a hangup or open failing. I wonder
> if its just a timing change ?

Can someone please try this? Looks like it only reproduces on ppc, I
can't get it to reproduce in my kvm vm. I'm trying to get hold of a ppc
box, though. (btw ppc, ppc64, both should trigger this, right?)

		Amit
