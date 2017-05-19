Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTcc00y3QzDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 15:50:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pavel Machek <pavel@denx.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: sr@denx.de, jwboyer@linux.vnet.ibm.com, robh+dt@kernel.org,
 mark.rutland@arm.com, benh@kernel.crashing.org, paulus@samba.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, trivial@kernel.org,
 Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc/sequoia: fix NAND partitions not to overlap
In-Reply-To: <20170518094813.GA12038@amd>
References: <20170402100535.GA18340@amd> <20170517120613.GA583@amd>
 <20170517143717.ad818a2282378fc7a38af1ff@linux-foundation.org>
 <20170518094813.GA12038@amd>
Date: Fri, 19 May 2017 15:50:55 +1000
Message-ID: <87efvl75ts.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pavel Machek <pavel@denx.de> writes:

> On Wed 2017-05-17 14:37:17, Andrew Morton wrote:
>> On Wed, 17 May 2017 14:06:13 +0200 Pavel Machek <pavel@denx.de> wrote:
>> 
>> > On Sun 2017-04-02 12:05:36, Pavel Machek wrote:
>> > > Fix overlapping NAND partitions.
>> > > 
>> > > Signed-off-by: Pavel Machek <pavel@ucw.cz>
>> > 
>> > Ping? Two partitions at same place are bad news...
>> 
>> Please expand on "bad news"?  What are the runtime effects of this
>> change?  Decisions about which kernel(s) to patch depend on this info.
>
> Well... two partitions at same place. If you use one, you will corrupt
> information on the other one.
>
> OTOH this moves partition around (so that they don't overlap) so it is
> probably not stable candidate.
>
> I guess this is not huge issue; people using these boards probably
> have custom dts changes, anyway...

Or no one's even using it anymore.

I can take this via powerpc, I won't mark it for stable etc.

cheers
