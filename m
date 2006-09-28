Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 74DC667B8B
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 02:43:28 +1000 (EST)
Date: Thu, 28 Sep 2006 20:43:45 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 8/12] qe_lib: Fix rheap alignment problem
Message-ID: <20060928204345.4e23789e@vitb.ru.mvista.com>
In-Reply-To: <9672B4B6-1DC0-48D6-99BA-7160421CB24C@kernel.crashing.org>
References: <451B8584.1070403@freescale.com>
	<9672B4B6-1DC0-48D6-99BA-7160421CB24C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Li Yang <leoli@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2006 09:10:18 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Sep 28, 2006, at 3:19 AM, Li Yang wrote:
> 
> > Honor alignment parameter in the rheap allocator.  This is
> > needed by qe_lib.
> > Remove compile warning.
> >
> > Signed-off-by: Pantelis Antoniou <pantelis@embeddedalley.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> 

OK, I can state rheap is still consistent in 8560 cpm2.
It even makes sense to apply this instantly because it's a notable bugfix.. Kumar?

-- 
Sincerely, 
Vitaly
