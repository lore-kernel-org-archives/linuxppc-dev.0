Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1DD13B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 19:26:06 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1OvoFc-000402-5a
	from <mingo@elte.hu>
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 11:26:00 +0200
Date: Wed, 15 Sep 2010 11:25:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warnings after merge of the final tree (tip
	treee related)
Message-ID: <20100915092532.GH16593@elte.hu>
References: <20100913132721.5a02cfbc.sfr@canb.auug.org.au>
	<4C8DA517.9000603@kernel.org>
	<20100913143942.7344ada4.sfr@canb.auug.org.au>
	<4C8DDFB4.1020508@kernel.org>
	<20100914145025.977ec2a6.sfr@canb.auug.org.au>
	<4C8FFE76.8070801@kernel.org>
	<20100915150047.42551e34.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100915150047.42551e34.sfr@canb.auug.org.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Yinghai,
> 
> On Tue, 14 Sep 2010 16:00:06 -0700 Yinghai Lu <yinghai@kernel.org> wrote:
> >
> > Also, we may need to remove all extern and __init and __initdata etc in .h files.
> > 
> > please check
> > 
> > [PATCH -v3] memblock: Fix section mismatch warning
> > 
> > Use __init_memblock to replace __init, and remove __init in memblock.h
> > 
> > -v2: more with memblock_is_meory()
> > -v3: remove __init for function declaring in memblock.h. Pointed out by Stephen.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Yinghai Lu <Yinghai@kernel.org>
> 
> This version fixes all the warnings for me.  So if you put the "extern"s
> back, you can add:
> 
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

Yinghai, mind posting the final version of the patch as a standalone 
posting, with a proper changelog, and with the extern issue fixed as 
well, plus all Reported-by and Tested-by tags added?

Thanks,

	Ingo
