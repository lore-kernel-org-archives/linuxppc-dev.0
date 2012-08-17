Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C59A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Aug 2012 06:17:53 +1000 (EST)
Message-ID: <1345234629.11751.82.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jan Engelhardt <jengelh@inai.de>
Date: Sat, 18 Aug 2012 06:17:09 +1000
In-Reply-To: <alpine.LNX.2.01.1208171548230.24880@frira.zrqbmnf.qr>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066551.11751.1.camel@pasglop>
 <alpine.LNX.2.01.1208161718210.8111@frira.zrqbmnf.qr>
 <1345150317.11751.38.camel@pasglop>
 <alpine.LNX.2.01.1208171548230.24880@frira.zrqbmnf.qr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-08-17 at 15:51 +0200, Jan Engelhardt wrote:
> 
> I can just exploit the fact that the machine will run for about an
> hour when it has had a cooldown night.
> 
> Except that 3.5, as I already expected by scary mails read on
> linux-kernel, looked dangerous to use. Here is a boot-time
> hang.

Heh, nice. Do you have a pointer to the scary emails ? I've seen that
hang on kernels built by David here but not on the ones I build on a
dual G5, I wonder if it has to do with one of the RCU config options ?

I was hoping I might have time next week to dig a bit...

Cheers,
Ben.
