Return-Path: <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>
Subject: Re: [PATCH 0/1] pasemi: Add fixup_device_tree function to prom_init
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 18 Jul 2016 21:16:12 +1000
From: mpe <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Olof Johansson <olof@lixom.net>,
 Christian Zigotzky <chzigotzky@xenosoft.de>, Linuxppc-dev
 <linuxppc-dev-bounces+mpe=ellerman.id.au@lists.ozlabs.org>
In-Reply-To: <487fa010858.3ea76b1c@auth.smtp.1and1.co.uk>
References: <487fa010858.3ea76b1c@auth.smtp.1and1.co.uk>
Message-ID: <5bb1da8238b302cb807cfd6b9dc2ca54@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-07-18 04:40, Darren Stevens wrote:
> Hello All,

Hi Darren,

> I'm currently working on some device tree patches for the AmigaOne 
> X1000,
> which I hope to push into the mainline kernel, however there is 
> currently no
> function for PASemi fixes, this patch introduces it. No code changes at
> this time.

I'd love to have those workarounds handled via a fixup function.

But I'd rather wait until we actually have some content for the 
function.
Is there any reason you need the empty version merged into mainline?

> This will be for 4.8 (if possible)

It's probably too late for 4.8. But send it whenever it's ready and I'll 
put
it in as soon as is practical.

cheers
