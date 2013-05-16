Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69EFA2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 15:46:09 +1000 (EST)
Message-ID: <1368683156.9603.34.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Qiang Liu <qiang.liu@freescale.com>
Date: Thu, 16 May 2013 15:45:56 +1000
In-Reply-To: <1368679657.9603.32.camel@pasglop>
References: <1368679657.9603.32.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Andy Fleming <afleming@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 14:47 +1000, Benjamin Herrenschmidt wrote:
> Hi folks !
> 
> So I was trying to use my 5020ds to test some stuff today. Since I
> hadn't used it in a while, I decided to "upgrade" it to the latest NOR
> etc...

On another note, I can't seem to get any PCIe card recognized in any
slot...

Can you give me an example config of the DIP switches that is known to
work with some slots ? Is there some EEPROM config needed ? If yes, any
pointers ? (I can't quite make sense of either u-boot or the doc there).

Thanks,
Ben.
