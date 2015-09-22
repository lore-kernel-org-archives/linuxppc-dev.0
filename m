Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id DE6921A0024
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 08:49:47 +1000 (AEST)
Subject: Re: [PATCH v2 22/25] powerpc32: move xxxxx_dcache_range() functions
 inline
To: Scott Wood <scottwood@freescale.com>
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
 <1442961271.19102.289.camel@freescale.com>
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5601DB07.3000205@c-s.fr>
Date: Wed, 23 Sep 2015 00:49:43 +0200
MIME-Version: 1.0
In-Reply-To: <1442961271.19102.289.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 23/09/2015 00:34, Scott Wood a écrit :
> On Tue, 2015-09-22 at 22:57 +0200, Christophe Leroy wrote:
>> >Here is what I get in asm. First one is with "if (i) mb();". We see gcc
>> >puts a beqlr. This is the form that is closest to what we had in the
>> >former misc_32.S
>> >Second one if with "mb()". Here we get a branch to sync for a useless sync
> I was more concerned with keeping the code simple than the asm output.
>
Right, but is that so complicated to say: if we did nothing in the loop, 
no need to sync ?

Christophe
