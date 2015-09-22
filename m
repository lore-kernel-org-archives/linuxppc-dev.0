Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0128.outbound.protection.outlook.com [207.46.100.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BE1F1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 08:52:49 +1000 (AEST)
Message-ID: <1442962353.19102.296.camel@freescale.com>
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Joakim Tjernlund <joakim.tjernlund@transmode.se>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 Sep 2015 17:52:33 -0500
In-Reply-To: <5601DB07.3000205@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <c1c88096cb3f6ee71048dbab44ffb9ac260b07a3.1442939410.git.christophe.leroy@c-s.fr>
 <1442945547.29498.50.camel@transmode.se>
 <1442948339.19102.270.camel@freescale.com>
 <1442950473.29498.54.camel@transmode.se>
 <1442950926.19102.280.camel@freescale.com>
 <1442951752.29498.58.camel@transmode.se>
 <1442952852.19102.281.camel@freescale.com>
 <1442953971.29498.76.camel@transmode.se>
 <1442954101.19102.286.camel@freescale.com>
 <1442954285.29498.79.camel@transmode.se> <5601C0CC.6090503@c-s.fr>
 <1442961271.19102.289.camel@freescale.com> <5601DB07.3000205@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-23 at 00:49 +0200, Christophe Leroy wrote:
> Le 23/09/2015 00:34, Scott Wood a écrit :
> > On Tue, 2015-09-22 at 22:57 +0200, Christophe Leroy wrote:
> > > > Here is what I get in asm. First one is with "if (i) mb();". We see 
> > > > gcc
> > > > puts a beqlr. This is the form that is closest to what we had in the
> > > > former misc_32.S
> > > > Second one if with "mb()". Here we get a branch to sync for a useless 
> > > > sync
> > I was more concerned with keeping the code simple than the asm output.
> > 
> Right, but is that so complicated to say: if we did nothing in the loop, 
> no need to sync ?

As I said, it doesn't matter very much.  I wouldn't put it in personally, but 
it's not worth a long discussion.

-Scott
