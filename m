Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18200.3600.459275.823335@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2007 11:53:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <471777BD.8090800@ru.mvista.com>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161C38.2070305@ru.mvista.com>
	<18198.44590.721412.314409@cargo.ozlabs.ibm.com>
	<471777BD.8090800@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov writes:

>     And now you have incomplete read_persistent_clock() implementation for 

I don't see anything incomplete about it.  If you do, feel free to
post a patch.

> example, god knows why it was preferred to mine -- well, it also implemented 

Your most recent post of your patch to implement read_persistent_clock
was in May -- five months ago -- and you said this about it: "This
patch hasn't received a good testing though".

You don't have to be a god to figure out why I preferred a patch that
had been tested, where the author was responding to comments and
posting updated versions of his patch in the period leading up to the
merge window, over that.

>     Well, that's up to you.  I take it you wouldn't accept a patch 
> implementing auto-reload mode?

I already told you.  Show me numbers (real measurements showing that
it's better) and I'll consider it.

>     There are. I'll have to send patches (it's not that I have time for this) 
> but this is surely the fastest way to get things fixed (if I don't get ignored 
> that is).

All of us only get stuff in by spending the time to develop patches
and posting them for comment.  Stop whinging.

>     I just wanted the reasons clarified and got what I wanted -- as I thought, 
> the decision behind preferring patches was somewhat biased, nobody really 
> cared about code quality or just wasn't familiar with hrtimers enough to judge 
> on the code quality...

You really know how to persuade people to cooperate, don't you...  :P

Paul.
