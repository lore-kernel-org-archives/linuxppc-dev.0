Return-Path: <sebastian.huber@embedded-brains.de>
Received: from dedi548.your-server.de (dedi548.your-server.de [85.10.215.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNXxV2wYkzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 21:47:26 +1000 (AEST)
Subject: Re: Status of DPAA integration for NXP QoriQ?
To: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org
References: <57304A64.1020607@embedded-brains.de>
 <1464998843.22191.44.camel@buserror.net>
Cc: Igal Liberman <igal.liberman@freescale.com>
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-ID: <575562C3.1060804@embedded-brains.de>
Date: Mon, 6 Jun 2016 13:47:15 +0200
MIME-Version: 1.0
In-Reply-To: <1464998843.22191.44.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/16 02:07, Scott Wood wrote:
> On Mon, 2016-05-09 at 10:29 +0200, Sebastian Huber wrote:
>> Hello,
>>
>> the "fman" Ethernet driver was integrated in mainline Linux Dezember
>> 2015 ("drivers/net/ethernet/freescale/fman"). It seems that the other
>> parts, e.g. BMan, QMan ("drivers/soc/fsl/qbman") and basic DPAA Ethern=
et
>> support ("drivers/net/ethernet/freescale/dpaa") are still missing. Are
>> there any plans to integrate them? I didn't notice any activity on the
>> mailing list in the last couple of months in this respect.
> Yes, we are still planning to integrate the other components.

Good to hear, do you plan to add support for receive checksum offload as=20
well?

https://freescale.jiveon.com/thread/388076

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
