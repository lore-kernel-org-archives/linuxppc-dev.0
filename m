Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id B6DA9DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 15:34:46 +1100 (EST)
Date: Mon, 30 Mar 2009 06:36:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc,
	Makefile: Make it possible to safely select CONFIG_FRAME_POINTER
Message-ID: <20090330043643.GA31362@uranus.ravnborg.org>
References: <20090320164404.GA19933@oksana.dev.rtsoft.ru>
	<20090320164429.GA28037@oksana.dev.rtsoft.ru>
	<1237607369.17367.7.camel@localhost.localdomain>
	<20090328104857.GA10897@oksana.dev.rtsoft.ru>
	<1238367290.20197.113.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238367290.20197.113.camel@pasglop>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 30, 2009 at 09:54:50AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2009-03-28 at 13:48 +0300, Anton Vorontsov wrote:
> > On Fri, Mar 20, 2009 at 11:49:29PM -0400, Steven Rostedt wrote:
> > > Ben,
> > > 
> > > Can you ACK this patch? Or even take it in your tree?
> > 
> > Benjamin, have you had a chance to look into this? Sam, could
> > you also take a look?
> 
> Those patches look ok. I'm a little bit surprised that -mno-sched-epilog
> isn't needed, gcc weirdness never ceases to amaze me, but the
> Makefile/Kconfig churning isn't for me to judge. If Sam is happy, then
> let's merge it.

I will take a closer look tonight or tomorrow - as day-time job permits.

	Sam
