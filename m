Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E84E6DDF7B
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 04:45:37 +1000 (EST)
Date: Fri, 12 Sep 2008 11:44:41 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 4/4] Add kernel doc for the completion, fix
	kernel-doc-nano-HOWTO.txt
Message-Id: <20080912114441.ce25096f.randy.dunlap@oracle.com>
In-Reply-To: <20080826083202.GA24733@elte.hu>
References: <48B29696.3070808@hypersurf.com> <20080826083202.GA24733@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Aug 2008 10:32:02 +0200 Ingo Molnar wrote:

> 
> * Kevin Diggs <kevdig@hypersurf.com> wrote:
> 
> > This patch adds kernel doc for the completion feature. It is in 
> > kernel/sched.c and include/linux/completion.h.
> >
> > An error in the split-man.pl PERL snippet in kernel-doc-nano-HOWTO.txt 
> > is also fixed.
> 
> applied to tip/sched/devel - thanks Kevin!

Ack and thanks, but next time, please describe the error that is being
fixed.

---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
