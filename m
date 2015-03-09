Return-Path: <ludovic.desroches@atmel.com>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AECE21A0371
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 03:18:42 +1100 (AEDT)
Date: Mon, 9 Mar 2015 17:11:57 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Message-ID: <20150309161157.GW9132@odux.rfo.atmel.com>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20150308082845.GB1904@katana>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On Sun, Mar 08, 2015 at 09:28:45AM +0100, Wolfram Sang wrote:
> On Wed, Feb 25, 2015 at 05:01:54PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Hi Ludovic,
> 
> if you have a few minutes, could you please test this series? I'd like to
> include it in 4.1. and because at91 is using the quirk infrastructure in
> a more complex way, it is a really good test candidate.

It was in the pipe. I have reviewed it, this second version seems to be
good. I am just waiting a bit more to give you my ack since I have some
issues to read an i2c eeprom (it works with a temperature sensor).
I am investigating if it doesn't come from a previous regression.

> 
> Thanks,
> 
>    Wolfram
> 

Regards

Ludovic
