Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv3M44hC7zDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 13:09:04 +1000 (AEST)
Message-ID: <1498187343.30922.0.camel@neuling.org>
Subject: Re: [PATCH] powerpc: Invalidate ERAT on powersave wakeup for POWER9
From: Michael Neuling <mikey@neuling.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 22 Jun 2017 22:09:03 -0500
In-Reply-To: <87lgojy1bk.fsf@linux.vnet.ibm.com>
References: <20170622172616.7598-1-mikey@neuling.org>
 <87lgojy1bk.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-23 at 10:50 +1000, Stewart Smith wrote:
> Michael Neuling <mikey@neuling.org> writes:
> > On POWER9 the ERAT may be incorrect on wakeup from some stop states
> > that lose state. This causes random segvs and illegal instructions
> > when these stop states are enabled.
> >=20
> > This patch invalidates the ERAT on wakeup on POWER9 to prevent this
> > from causing a problem.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> CC: stable?

Yes please!

Mikey
