Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zlRJ0V04zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 07:30:19 +1000 (AEST)
Message-ID: <07ad630cccbd33c81031f690fd17cdc30b662e49.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 27 Aug 2018 16:28:03 -0500
In-Reply-To: <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
References: <0F797F4E-755B-499C-BA74-48CC03235393@xenosoft.de>
 <76A7B415-F6D4-4BF8-B4B7-B146C5337CF8@xenosoft.de>
 <196C6151-3085-4A42-B6D6-5891F4AF9759@xenosoft.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: FSL/NXP P5020: USB problems with the latest Git kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-27 at 20:15 +0200, Christian Zigotzky wrote:
> Hello,
> 
> Our users tested the RC1 of kernel 4.19 on their P5020 boards today.
> Unfortunately the USB bug still exists. With mem values bigger than 4096M,
> the USB mouse and keyboard doesn’t work. With the bootarg mem=4096M, the USB
> devices work without any problems. Please compile the RC1 and test it on
> your P5020 board. There is a problem with the memory management since
> 22/08/18. 

I just tested 4.19-rc1 on a T4240 and got a similar problem with MMC.  MMC and
USB on these chips both have a 32-bit DMA limitation.  I'll look into it.

-Scott
