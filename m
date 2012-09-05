Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 05B2A2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 07:13:28 +1000 (EST)
Message-ID: <1346879598.19098.4.camel@pasglop>
Subject: Re: [PATCH v2] powerpc: fix personality handling in
 ppc64_personality()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jiri Kosina <jkosina@suse.cz>
Date: Thu, 06 Sep 2012 07:13:18 +1000
In-Reply-To: <alpine.LNX.2.00.1209051056060.11079@pobox.suse.cz>
References: <alpine.LNX.2.00.1208012201520.14910@pobox.suse.cz>
 <m27gtitfv4.fsf@igel.home>
 <alpine.LNX.2.00.1208020907490.14910@pobox.suse.cz>
 <1346813643.2257.24.camel@pasglop>
 <alpine.LNX.2.00.1209051056060.11079@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-09-05 at 10:56 +0200, Jiri Kosina wrote:

> Hi Benjamin,
> 
> actually commit 7256a5d2da56 seems to contain the correct PER_LINUX 
> handling, so seems like you picked the right one :)
> 

Odd, they looked different around the use of PER_MASK when I looked but
I was tired & jet lagged, so I might have just had a brain fail...

Cheers,
Ben.
