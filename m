Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 303B01A0039
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 01:10:22 +1000 (EST)
Message-ID: <5395CC7C.4040608@Freescale.com>
Date: Mon, 9 Jun 2014 10:02:20 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Tony <blacklites@gmail.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: <fsl,qman-channel-id> in dts file
References: <CAE1uq6vw0VSDUymckX51FyoJ8NH4Gsj3npfiYeZNff1Vq0cKsQ@mail.gmail.com>
In-Reply-To: <CAE1uq6vw0VSDUymckX51FyoJ8NH4Gsj3npfiYeZNff1Vq0cKsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Tony,


On 06/09/2014 06:43 AM, Tony wrote:
> How's the fsl,qman-channel-id value different for different targets ?

Channel ids are assigned in hardware

> Is there any document on how this value is achieved ?

They are described in the RM of each SoC and in the DPAA RM

> Or can it be any value ???

Nope. It must be the right value or frames will end up in the wrong
portal or worse


Cheers,
