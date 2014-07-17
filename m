Return-Path: <hs@denx.de>
Received: from submit1.sa.ew.hu (submit1.sa.ew.hu [212.108.200.71])
 by lists.ozlabs.org (Postfix) with ESMTP id 3E3631A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 21:44:21 +1000 (EST)
Message-ID: <53C7B70F.5040904@denx.de>
Date: Thu, 17 Jul 2014 13:44:15 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: spi, spi_fsl-spi.c not working?
References: <53C79351.2080406@denx.de> <20140717113129.GU17528@sirena.org.uk>
In-Reply-To: <20140717113129.GU17528@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andreas Larsson <andreas@gaisler.com>, linux-spi@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Mark,

Am 17.07.2014 13:31, schrieb Mark Brown:
> On Thu, Jul 17, 2014 at 11:11:45AM +0200, Heiko Schocher wrote:
>
>> Is it maybe the missing "support for the SPI subsystem's queue SPI messages"?
>
> It shouldn't be that, that's still optional (sadly).

Thanks for this info! I digging in it ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
