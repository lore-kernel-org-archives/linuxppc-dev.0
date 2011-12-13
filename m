Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe002.messaging.microsoft.com
 [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CAF0E1007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 06:29:03 +1100 (EST)
Message-ID: <4EE7A776.70609@freescale.com>
Date: Tue, 13 Dec 2011 13:28:54 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Linux port availability for p5010 processor
References: <CAFbQSaALfZ-6-_g5aC1GgbUaoHyuBwaT342OFMTSf0iqtakDGA@mail.gmail.com>
In-Reply-To: <CAFbQSaALfZ-6-_g5aC1GgbUaoHyuBwaT342OFMTSf0iqtakDGA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Senthil CGC <senthilece2005@gmail.com>,
 rajarama.b@coreel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2011 11:33 PM, Vineeth wrote:
> Do we have a linux port available for freescale P5010 processor (with
> single E5500 core) ?
> /(found arch/powerpc/platforms/pseries ; and a some details on
> kernel/cputable.c /)

p5010 is basically a p5020 with one core and "memory complex" instead of
two.  The same Linux code should work for both.

pseries is something completely different.

> Is there any reference board which uses this processor ?

p5020ds has a p5020.

Linux support is in arch/powerpc/platforms/85xx/p5020_ds.c (and
scattered in other places).

> any reference in DTS file also will be helpful.

arch/powerpc/boot/dts/p5020ds.dts

-Scott
