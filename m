Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 36B5DDDF2A
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 16:42:29 +1100 (EST)
Date: Fri, 19 Dec 2008 00:42:25 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/5] powerpc: ftrace updates to previous patch series
In-Reply-To: <18763.10937.847276.371262@drongo.ozlabs.ibm.com>
Message-ID: <alpine.DEB.1.10.0812190032300.17609@gandalf.stny.rr.com>
References: <20081126215821.263324391@goodmis.org>
	<alpine.DEB.1.10.0811261749310.1501@gandalf.stny.rr.com>
	<20081128131014.GC26793@elte.hu>
	<alpine.DEB.1.10.0812011315020.7645@gandalf.stny.rr.com>
	<18763.10937.847276.371262@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 19 Dec 2008, Paul Mackerras wrote:

> Steven Rostedt writes:
> 
> > Sorry, I rebased to edit the change log where I mispelled Paul's name.
> 
> So, what commits should I be pulling into powerpc.git, or what patches
> should I be committing, for dynamic ftrace on powerpc?

Ingo did not like the rebase and kept the original commits (the one with 
the change log with the incorrect spelling).

From: git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git
  tracing/powerpc
====================================
commit 8fd6e5a8c81e2e9b912ea33c8425a10729db469b
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Fri Nov 14 16:21:19 2008 -0800

    powerpc: ftrace, convert to new dynamic ftrace arch API
    
    Impact: update to PowerPC ftrace arch API
    
    This patch converts PowerPC to use the new dynamic ftrace arch API.
    
    Thanks to Paul Mackennas for pointing out the mistakes of my original
    test_24bit_addr function.
    
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>
====================================

The branch in my tree 'ppc/ftrace' has not been changed since. The only 
reason the commits in my tree are different than the ones in tip was 
because I rebased to fixed the spelling in the change log.

From: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
  ppc/ftrace
====================================
commit a3520364f9376943e4d6c76931bf4df8569fa555
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Fri Nov 14 16:21:19 2008 -0800

    powerpc: ftrace, convert to new dynamic ftrace arch API
    
    Impact: update to PowerPC ftrace arch API
    
    This patch converts PowerPC to use the new dynamic ftrace arch API.
    
    Thanks to Paul Mackerras for pointing out the mistakes of my original
    test_24bit_addr function.
    
    Signed-off-by: Steven Rostedt <srostedt@redhat.com>
====================================

Take your pick for which to pull from.

Thanks,

-- Steve
