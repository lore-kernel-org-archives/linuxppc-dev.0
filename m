Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 4CE04679F7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:47:42 +1000 (EST)
Date: Thu, 27 Apr 2006 15:47:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Message-ID: <20060427134703.GL32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
	<20060427123701.GG32127@wohnheim.fh-wedel.de>
	<84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <84144f020604270642j788be2ecp82841ac3b3ebcaad@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 16:42:52 +0300, Pekka Enberg wrote:
> On 4/27/06, Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> > The whole patch is full of parameter-happy functions with this one
> > being the ugly top of the iceberg.  I sincerely hope this is not a
> > defined ABI and can still be changed.
> 
> It's not in mainline, so it can be changed.

I was thinking more about firmware ABI.

Jörn

-- 
But this is not to say that the main benefit of Linux and other GPL
software is lower-cost. Control is the main benefit--cost is secondary.
-- Bruce Perens
