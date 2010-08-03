Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 657101007D2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 15:51:11 +1000 (EST)
Date: Tue, 3 Aug 2010 07:51:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Please pull my perf.git urgent branch
Message-ID: <20100803055101.GC1130@elte.hu>
References: <20100727124019.GB14947@brick.ozlabs.ibm.com>
	<20100727112854.7bf97d48@schlenkerla.am.freescale.net>
	<20100728044731.GA2408@brick.ozlabs.ibm.com>
	<20100802171654.1776759c@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100802171654.1776759c@schlenkerla.am.freescale.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Scott Wood <scottwood@freescale.com> wrote:

> On Wed, 28 Jul 2010 14:47:31 +1000
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > On Tue, Jul 27, 2010 at 11:28:54AM -0500, Scott Wood wrote:
> > 
> > > Doesn't the setting of .period need to be maintained (it is in the other
> > > powerpc perf_event implementation that this is derived from)?
> > 
> > Gah, yes it does.
> 
> Well, looks like Linus pulled anyway...  I'll send a patch to
> add .period.

Yes, the original commit was already upstream when you reported this bug.

Paul added a -stable tag to the fix so it will get into the .35.1 pipeline 
this week.

Thanks,

	Ingo
