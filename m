Return-Path: <rientjes@google.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE868B6F9F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 12:44:44 +1000 (EST)
Received: by dajt11 with SMTP id t11so9631682daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2012 19:44:42 -0700 (PDT)
Date: Mon, 21 May 2012 19:44:40 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: linux-next: PowerPC boot failures in next-20120521
In-Reply-To: <2246.1337654423@neuling.org>
Message-ID: <alpine.DEB.2.00.1205211942540.29814@chino.kir.corp.google.com>
References: <20120522114051.0c9db9a7c2d660bc9e0e1be2@canb.auug.org.au>
 <328.1337652722@neuling.org>
 <alpine.DEB.2.00.1205211924390.13682@chino.kir.corp.google.com>
 <2182.1337654352@neuling.org> <2246.1337654423@neuling.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Peter Zijlstra <peterz@infradead.org>,
 Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 22 May 2012, Michael Neuling wrote:

> > > > Trying David's patch just posted doesn't fix it.
> > > > 
> > > 
> > > Hmm, what does CONFIG_DEBUG_VM say?
> > 
> > No set.
> 
> Sorry, should have read "Not set"
> 

I mean if it's set, what does it emit to the kernel log with my patch 
applied?

I made CONFIG_DEBUG_VM catch !node_online(node) about six months ago, so I 
was thinking it would have caught this if either you or Stephen enable it.
