Return-Path: <johnpol@2ka.mipt.ru>
Received: from 2ka.mipt.ru (relay.2ka.mipt.ru [194.85.82.65])
	by ozlabs.org (Postfix) with ESMTP id CCA1ADDFD4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 02:01:06 +1000 (EST)
Date: Mon, 2 Jun 2008 20:00:12 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-ID: <20080602160012.GB32511@2ka.mipt.ru>
References: <4840585D.8050805@freescale.com>
	<20080530151638.087970ab.kim.phillips@freescale.com>
	<4840615F.4070103@freescale.com>
	<20080530153505.21eb1ec4.kim.phillips@freescale.com>
	<48406562.4010306@freescale.com>
	<20080530154820.6e56b625.kim.phillips@freescale.com>
	<20080530211204.GA15768@2ka.mipt.ru>
	<20080530171930.61965d59.kim.phillips@freescale.com>
	<20080531095901.GA16281@2ka.mipt.ru>
	<20080602092701.9d0d56e8.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080602092701.9d0d56e8.kim.phillips@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	mr.scada@gmail.com, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 02, 2008 at 09:27:01AM -0500, Kim Phillips (kim.phillips@freescale.com) wrote:
> > I meant descriptor hdr value accessed via it - can it be checked in
> > tasklet under the lock and in submit path without? Can they correlate
> > somehow?
> 
> I believe the check for a non-null request->desc (under lock) before
> the hdr value is accessed ensures this doesn't happen.

But can it be changed? You write to it without lock, but read under the
one (different for each channel though), so it attracted attention.

-- 
	Evgeniy Polyakov
