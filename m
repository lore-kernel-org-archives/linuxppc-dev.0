Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AD15DE11A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 07:59:10 +1000 (EST)
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Piotr =?UTF-8?Q?Zi=C4=99cik?= <kosmo@semihalf.com>
In-Reply-To: <200905191326.29122.kosmo@semihalf.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<fa686aa40905140700k3ca28ac0m74c9c161ad538abc@mail.gmail.com>
	<1242685051.16901.6.camel@pasglop>
	<200905191326.29122.kosmo@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 May 2009 07:56:42 +1000
Message-Id: <1242770202.16901.116.camel@pasglop>
Mime-Version: 1.0
Cc: Becky Bruce <Becky.Bruce@freescale.com>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, John Rigby <jrigby@gmail.com>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-05-19 at 13:26 +0200, Piotr Zięcik wrote:
> Tuesday 19 May 2009 00:17:31 Benjamin Herrenschmidt wrote:
> >
> > We are close to the point where we can make this a runtime option
> > though, by just having a different set of dma_ops hooked in.
> >
> 
> Is somebody currently working on it? If yes, where we can see
> code ?

Well, the current upstream code has the dma ops support. Becky is
massaging that more for swiotlb support which has been submitted to the
linuxppc-dev list. We haven't yet added runtime support rather than
compile time for non-cache coherent platforms, but it's becoming
reasonably easy to add now (though still needs to be done).

Cheers,
Ben
