Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id F3D75B7D07
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 16:22:28 +1100 (EST)
Received: from m5.gw.fujitsu.co.jp ([10.0.50.75])
	by fgwmail7.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o185MR7v013716 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 14:22:27 +0900
Received: from smail (m5 [127.0.0.1])
	by outgoing.m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 4220F2E68C2
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:22:27 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (s5.gw.fujitsu.co.jp [10.0.50.95])
	by m5.gw.fujitsu.co.jp (Postfix) with ESMTP id 22D021EF085
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:22:27 +0900 (JST)
Received: from s5.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id D8198E18005
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:22:26 +0900 (JST)
Received: from m108.s.css.fujitsu.com (m108.s.css.fujitsu.com [10.249.87.108])
	by s5.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CE41E18002
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 14:22:23 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
In-Reply-To: <20100208051104.GL32246@kryten>
References: <20100208140323.FB52.A69D9226@jp.fujitsu.com>
	<20100208051104.GL32246@kryten>
Message-Id: <20100208141716.FB55.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Mon,  8 Feb 2010 14:22:22 +0900 (JST)
Cc: Michael Neuling <mikey@neuling.org>, stable@kernel.org, aeb@cwi.nl,
	Oleg Nesterov <oleg@redhat.com>, miltonm@bga.com,
	James Morris <jmorris@namei.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, kosaki.motohiro@jp.fujitsu.com,
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

>  
> Hi,
> 
> > Why do we need page size independent stack size? It seems to have
> > compatibility breaking risk.
> 
> I don't think so. The current behaviour is clearly wrong, we dont need a
> 16x larger stack just because you went from a 4kB to a 64kB base page
> size. The user application stack usage is the same in both cases.

I didn't discuss which behavior is better. Michael said he want to apply
his patch to 2.6.32 & 2.6.33. stable tree never accept the breaking
compatibility patch.

Your answer doesn't explain why can't we wait it until next merge window.


btw, personally, I like page size indepent stack size. but I'm not sure
why making stack size independency is related to bug fix.
