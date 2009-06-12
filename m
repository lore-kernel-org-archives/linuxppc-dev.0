Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1359B721D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:56:04 +1000 (EST)
Date: Fri, 12 Jun 2009 11:55:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: linux-next: origin tree build failure
Message-ID: <20090612095546.GA23020@elte.hu>
References: <20090612102427.32582baa.sfr@canb.auug.org.au>
	<1244768406.7172.1.camel@pasglop> <20090612092054.GB32052@elte.hu>
	<1244799197.7172.106.camel@pasglop>
	<1244799786.6691.1133.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244799786.6691.1133.camel@laptop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	paulus@samba.org, Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> On Fri, 2009-06-12 at 19:33 +1000, Benjamin Herrenschmidt wrote:
> > We should at least -try- to follow the
> > process we've defined, don't you think ?
>
> So you're saying -next should include whole new subsystems even 
> though its not clear they will be merged?
> 
> That'll invariably create the opposite case where a tree doesn't 
> get pulled and breaks bits due to its absence.
> 
> -next does a great job of sorting the existing subsystem trees, 
> but I don't think its Stephens job to decide if things will get 
> merged.
> 
> Therefore when things are in limbo (there was no definite ACK from 
> Linus on perf counters) both inclusion and exclusion from -next 
> can lead to trouble.

Precisely. linux-next is for the uncontroversial stuff from existing 
subsystems. Sometimes for features pushed by or approved by existing 
subsystem maintainers. But it is not for controversial stuff - Linus 
is the upstream maintainer, not Stephen.

We had a real mess with perfmon3 which was included into linux-next 
in a rouge way without Cc:-ing the affected maintainers and against 
the maintainers. There was a repeat incident recently as well, where 
a tree was included into linux-next without the approval (and 
without the Cc:) of affected maintainers. linux-next needs to be 
more careful about adding trees.

All in one, we did the same with perfcounters that we expected of 
perfmonv3. No double standard.

Nor is there any real issue here. The bug was my fault, it was 
trivial to fix, it affects a small subset of testers and it is 
already upstream, applied on the same day perfcounters were pulled.

	Ingo
