Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 16:11:04 +1100
From: Anton Blanchard <anton@samba.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH] Restrict stack space reservation to rlimit
Message-ID: <20100208051104.GL32246@kryten>
References: <10125.1265451732@neuling.org> <18033.1265587672@neuling.org>
	<20100208140323.FB52.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100208140323.FB52.A69D9226@jp.fujitsu.com>
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

> Why do we need page size independent stack size? It seems to have
> compatibility breaking risk.

I don't think so. The current behaviour is clearly wrong, we dont need a
16x larger stack just because you went from a 4kB to a 64kB base page
size. The user application stack usage is the same in both cases.

Anton
