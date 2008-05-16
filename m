Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F531DE010
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 22:07:14 +1000 (EST)
Date: Fri, 16 May 2008 14:06:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] ftrace: support for PowerPC
Message-ID: <20080516120620.GD11718@elte.hu>
References: <20080515034942.109223655@goodmis.org>
	<20080515035918.896765954@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080515035918.896765954@goodmis.org>
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <srostedt@redhat.com>, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> This patch adds full support for ftrace for PowerPC (both 64 and 32 
> bit). This includes dynamic tracing and function filtering.

applied, thanks. Nice stuff! :)

	Ingo
