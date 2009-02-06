Return-Path: <rostedt@goodmis.org>
Received: from localhost.localdomain (cpe-74-67-89-75.stny.res.rr.com
	[74.67.89.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F01B9DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 18:18:50 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc, ftrace: fix compile error when modules
	not configured
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <12951.1233901432@neuling.org>
References: <20090206060328.181057235@goodmis.org>
	<20090206060527.369616736@goodmis.org> <12951.1233901432@neuling.org>
Content-Type: text/plain
Date: Fri, 06 Feb 2009 01:27:06 -0500
Message-Id: <1233901626.16878.51.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2009-02-06 at 17:23 +1100, Michael Neuling wrote:
> In message <20090206060527.369616736@goodmis.org> you wrote:
> > From: Steven Rostedt <srostedt@redhat.com>
> > 
> > Michael Neuling reported a compile bug when dynamic ftrace was
> > configured in and modules were not. This was due to the ftrace
> > code referencing module specific structures.
> > 
> > Reported-by: Michael Neuling <mikey@neuling.org>
> > Signed-off-by: Steven Rostedt <srostedt@redhat.com>
> 
> Steve,
> 
> Thanks, fixes the error I was seeing.  

Cool.

> 
> As an aside, is there anyway we can merge some of the code in
> arch/powerpc/kernel/ftrace.c between 32 and 64bit?  There seems to be a
> lot of repeated code in there with only minor changes.

It looks similar, but there's enough differences that I would like to
keep them separate. The code is complex enough and has a lot of subtle
differences between the two archs.

-- Steve
