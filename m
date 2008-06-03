Return-Path: <johnpol@2ka.mipt.ru>
Received: from 2ka.mipt.ru (relay.2ka.mipt.ru [194.85.82.65])
	by ozlabs.org (Postfix) with ESMTP id D0739DDF51
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 11:24:20 +1000 (EST)
Date: Tue, 3 Jun 2008 05:24:17 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 2/2] talitos: Freescale integrated security engine (SEC)
	driver
Message-ID: <20080603012416.GA20254@2ka.mipt.ru>
References: <48406562.4010306@freescale.com>
	<20080530154820.6e56b625.kim.phillips@freescale.com>
	<20080530211204.GA15768@2ka.mipt.ru>
	<20080530171930.61965d59.kim.phillips@freescale.com>
	<20080531095901.GA16281@2ka.mipt.ru>
	<20080602092701.9d0d56e8.kim.phillips@freescale.com>
	<20080602160012.GB32511@2ka.mipt.ru>
	<20080602115021.cdda8647.kim.phillips@freescale.com>
	<20080602175751.GA7807@2ka.mipt.ru>
	<20080602140603.02d5f40f.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080602140603.02d5f40f.kim.phillips@freescale.com>
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

Hi.

On Mon, Jun 02, 2008 at 02:06:03PM -0500, Kim Phillips (kim.phillips@freescale.com) wrote:
> it would be an issue if flush_cannel didn't save off the data required
> to call the callback with in saved_req.  flush_channel does this on
> purpose to be able to call the callback outside of lock (as is
> commented).  Note desc gets assigned NULL prior to releasing the lock,
> after copying its contents to saved_req.

Excellent! It looks like there are no more issues and second version
fixed found problem place.

-- 
	Evgeniy Polyakov
