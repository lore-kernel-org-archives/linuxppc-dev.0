Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4E42DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 06:04:36 +1100 (EST)
Date: Fri, 20 Mar 2009 20:04:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] tracing: Fix TRACING_SUPPORT dependency
Message-ID: <20090320190428.GD6224@elte.hu>
References: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090320150914.GA22769@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> commit 40ada30f9621fbd831ac2437b9a2a399aad34b00 ("tracing: clean 
> up menu"), despite the "clean up" in its purpose, introduced 
> behavioural change for Kconfig symbols: we no longer able to 
> select tracing support on PPC32 (because IRQFLAGS_SUPPORT isn't 
> yet implemented).

Could you please solve this by implementing proper irqflag-tracing 
support? It's been available upstream for almost three years. It's 
needed for lockdep support as well, etc.

	Ingo
