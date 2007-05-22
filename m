Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 65A1BDDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 04:52:38 +1000 (EST)
Subject: Re: [PATCH] powerpc 2.6.21-rt6: revert spider_net
From: Thomas Gleixner <tglx@linutronix.de>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070522184632.GL5921@austin.ibm.com>
References: <yyi646l6pmr.wl@toshiba.co.jp>
	<20070522184632.GL5921@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 22 May 2007 20:52:34 +0200
Message-Id: <1179859954.12708.130.camel@chaos>
Mime-Version: 1.0
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 13:46 -0500, Linas Vepstas wrote:
> On Tue, May 22, 2007 at 08:53:32PM +0900, Tsutomu OWA wrote:
> > 
> > Hi Ingo and Thomas,
> >
> > To revert spider_net.c to original one as it turns out that the patch 
> 
> As the spidernet maintainer, I had not forwarded the previous patch
> upstream; it should not have been applied.

Linas,

that's against preempt-rt, where we picked up owa-sans patch.

Thanks,

	tglx
