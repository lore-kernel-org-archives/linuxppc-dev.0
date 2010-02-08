Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id EFAA0B7D14
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 17:12:08 +1100 (EST)
Received: from m4.gw.fujitsu.co.jp ([10.0.50.74])
	by fgwmail5.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	o186C7W1010409 for <linuxppc-dev@ozlabs.org> (envelope-from
	kosaki.motohiro@jp.fujitsu.com); Mon, 8 Feb 2010 15:12:07 +0900
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F189345DE83
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:12:06 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1499C45DE79
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:12:06 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C0D11DB8037
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:12:05 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.249.87.103])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id DF95A1DB8043
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Feb 2010 15:11:59 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
In-Reply-To: <20100208053125.GN32246@kryten>
References: <20100208141716.FB55.A69D9226@jp.fujitsu.com>
	<20100208053125.GN32246@kryten>
Message-Id: <20100208151128.FB5E.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Mon,  8 Feb 2010 15:11:58 +0900 (JST)
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
> > I didn't discuss which behavior is better. Michael said he want to apply
> > his patch to 2.6.32 & 2.6.33. stable tree never accept the breaking
> > compatibility patch.
> > 
> > Your answer doesn't explain why can't we wait it until next merge window.
> > 
> > 
> > btw, personally, I like page size indepent stack size. but I'm not sure
> > why making stack size independency is related to bug fix.
> 
> OK sorry, I misunderstood your initial mail. I agree fixing the bit that
> regressed in 2.6.32 is the most important thing. The difference in page size is
> clearly wrong but since it isn't a regression we could probably live with it
> until 2.6.34

thanks!
