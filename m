Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 16:31:25 +1100
From: Anton Blanchard <anton@samba.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
Message-ID: <20100208053125.GN32246@kryten>
References: <20100208140323.FB52.A69D9226@jp.fujitsu.com>
	<20100208051104.GL32246@kryten>
	<20100208141716.FB55.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208141716.FB55.A69D9226@jp.fujitsu.com>
Cc: Michael Neuling <mikey@neuling.org>, stable@kernel.org, aeb@cwi.nl,
	James Morris <jmorris@namei.org>, miltonm@bga.com,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	WANG Cong <xiyou.wangcong@gmail.com>,
	linux-fsdevel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> I didn't discuss which behavior is better. Michael said he want to apply
> his patch to 2.6.32 & 2.6.33. stable tree never accept the breaking
> compatibility patch.
> 
> Your answer doesn't explain why can't we wait it until next merge window.
> 
> 
> btw, personally, I like page size indepent stack size. but I'm not sure
> why making stack size independency is related to bug fix.

OK sorry, I misunderstood your initial mail. I agree fixing the bit that
regressed in 2.6.32 is the most important thing. The difference in page size is
clearly wrong but since it isn't a regression we could probably live with it
until 2.6.34

Anton
