Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 77A19DDFEB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:52:00 +1000 (EST)
Date: Tue, 20 May 2008 10:51:58 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] ftrace: support for PowerPC
In-Reply-To: <1211293059.8297.166.camel@pasglop>
Message-ID: <Pine.LNX.4.58.0805201051210.2210@gandalf.stny.rr.com>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
	<1211292277.7960.8.camel@localhost> <1211293059.8297.166.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, paulus@samba.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 20 May 2008, Benjamin Herrenschmidt wrote:

> > Why do we not want to trace early boot? Just because it's not useful?
>
> Not running at the linked address... might be causing trouble.

I figured it was something like that, so I didn't look too deep into it,
and decided that it was best just not to trace it.

-- Steve
