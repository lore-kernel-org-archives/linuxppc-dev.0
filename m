Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 701E62C007C
 for <linuxppc-dev@ozlabs.org>; Sun,  2 Sep 2012 12:54:57 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC64 & DMA zone
Date: Sun, 2 Sep 2012 02:54:50 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708019EB2@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20120817200406.GA1908@harshnoise.musicnaut.iki.fi>
 <1345236056.11781.1.camel@pasglop>
In-Reply-To: <1345236056.11781.1.camel@pasglop>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 17, 2012 at 3:40 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2012-08-17 at 23:04 +0300, Aaro Koskinen wrote:
>> Hi,
>>
>> Is there a way to reduce/limit DMA zone with PPC64 kernel (3.6-rcX)
>> on G5 Mac? I have tried to search Kconfig or command line options,
>> but can't find anything.
>
> No.

What about Shaohui patches for ZONE_DMA?  That's meant to solve
exactly this problem?  Granted, it sets the DMA zone to 31 bits, but
it's simple to hack that to 30 bits.

--=20
Timur Tabi
Linux kernel developer at Freescale=
