Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9238EDE304
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 01:44:24 +1000 (EST)
Date: Tue, 8 Jul 2008 19:44:21 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Samuel Ortiz <samuel@sortiz.org>
Subject: Re: [PATCH] irda: driver for Freescale FIRI controller
Message-ID: <20080708154421.GA4471@polina.dev.rtsoft.ru>
References: <20080604154510.GA31162@polina.dev.rtsoft.ru>
	<20080611222524.GA6710@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080611222524.GA6710@sortiz.org>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Timur Tabi <timur@freescale.com>, Zhang Wei <Wei.Zhang@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 12:25:25AM +0200, Samuel Ortiz wrote:
> Hi Anton,
> 
> On Wed, Jun 04, 2008 at 07:45:10PM +0400, Anton Vorontsov wrote:
> > From: Zhang Wei <wei.zhang@freescale.com>
> > 
> > The driver supports SIR, MIR, FIR modes and maximum 4000000bps rate.
> > 
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > [AV: few small fixes, plus had made platform ops passing via node->data
> >      to avoid #ifdef stuff in the fsl_soc (think DIU). ]
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Some comments below:

Sorry, it took me so long to answer. :-/

Much thanks for the comments, will fix them all. That is, your review
work isn't in vain, I'm much appreciated it.

Thanks again,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
