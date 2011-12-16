Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 124B91007D6
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2011 12:58:08 +1100 (EST)
Message-ID: <4EEAA585.700@windriver.com>
Date: Fri, 16 Dec 2011 09:57:25 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Vineeth <vneethv@gmail.com>
Subject: Re: Linux port availability for p5010 processor
References: <CAFbQSaALfZ-6-_g5aC1GgbUaoHyuBwaT342OFMTSf0iqtakDGA@mail.gmail.com>
 <4EE7A776.70609@freescale.com>
 <CAFbQSaA6yK7d+O0C6-BguKamRcBNnsU-yimO48cQV8G_evmJjw@mail.gmail.com>
In-Reply-To: <CAFbQSaA6yK7d+O0C6-BguKamRcBNnsU-yimO48cQV8G_evmJjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Vineeth wrote:
> found p5020_ds.c in platforms/85xx;
> why is it a part of 85xx directory ? the core of P5020 is E5500 where the
> core of 85xx is e500;
> 

e5500 is e500mc-64bit Power Architecture core.

> Do we have the processor initialization code (start.S, head.S) files, port
> available with linux ?
> 

So it should go head_64.S/entry_64.S with CONFIG_PPC_BOOK3E.

Tiejun
