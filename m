Return-Path: <martijn.de.gouw@prodrive-technologies.com>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by lists.ozlabs.org (Postfix) with ESMTP id 81BAD1A0042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 18:48:04 +1000 (EST)
Message-ID: <53E9D4C0.5030203@prodrive-technologies.com>
Date: Tue, 12 Aug 2014 10:48:00 +0200
From: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fsl-rio: add support for mapping inbound windows
References: <1407246752-21639-1-git-send-email-martijn.de.gouw@prodrive-technologies.com>
 <1407274663.7427.7.camel@snotra.buserror.net>
In-Reply-To: <1407274663.7427.7.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Alexandre.Bounine@idt.com, Liu Gang <Gang.Liu@freescale.com>,
 Barry.Wood@idt.com, linuxppc-dev@lists.ozlabs.org,
 stef.van.os@prodrive-technologies.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/05/2014 11:37 PM, Scott Wood wrote:
> On Tue, 2014-08-05 at 15:52 +0200, Martijn de Gouw wrote:
>> Add support for mapping and unmapping of inbound rapidio windows.
>>
>> Signed-off-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
>
> Could you elaborate in the changelog on what this fixes or makes
> possible?  E.g. did the driver previously not support inbound
> transactions at all, or did it assume the window was set up by a
> bootloader?

Something like:

fsl-rio: add support for mapping inbound windows

     Add support for mapping and unmapping of inbound rapidio windows.
     This allows for drivers to open up a part of local memory on the
     rapidio network. Also applications can use this and tranfer blocks
     of data over the network.

>
> Liu Gang, could you review this?

I'll wait for the review before I post a new version.

Gr, Martijn


-- 
Martijn de Gouw
Engineer
Prodrive Technologies B.V.
Mobile: +31 63 17 76 161
Phone:  +31 40 26 76 200
