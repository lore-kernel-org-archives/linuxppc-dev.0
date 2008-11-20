Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 97963474C6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:15:47 +1100 (EST)
Date: Thu, 20 Nov 2008 14:15:45 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] powerpc: dynamic ftrace port
In-Reply-To: <20081120190948.057007623@goodmis.org>
Message-ID: <alpine.DEB.1.10.0811201412230.3378@gandalf.stny.rr.com>
References: <20081120190948.057007623@goodmis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Gleixner <tglx@linutronix.de>, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 20 Nov 2008, Steven Rostedt wrote:
> 
>  1) I removed the changes to recordmcount.pl.  This is not a PowerPC
>     change, although PowerPC needs it for dynamic ftrace. But
>     the changes here can go via linux-tip.

Ingo,

I found that the recordmcount.pl change conflicts with a commit
in linux-next, which is not in tip nor mainline. The commit is:

   11ebca4a3f8337de2f4d1300bd307851d1191d53
   sh: dynamic ftrace support.

Seems that this change came in through the sh repo. I have already
resolved the conflicts with my updates for PowerPC with this commit.
I can put this in a separate branch against linux-next if you like.

I would like to get the changes to recordmcount.pl for PowerPC
in linux-next soon, so I can also add a small clean up of this code.
Jim Radfort has some updates as well for his port to arm.

-- Steve
