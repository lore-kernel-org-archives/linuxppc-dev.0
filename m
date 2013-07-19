Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id C21CC2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2013 03:44:08 +1000 (EST)
Date: Fri, 19 Jul 2013 20:43:00 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: therm_pm72 units, interface
Message-ID: <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358465885.2782.24.camel@pasglop>
Cc: Jan Engelhardt <jengelh@inai.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 18, 2013 at 10:38:05AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2013-01-17 at 15:38 +0100, Jan Engelhardt wrote:
> > Meanwhile, I run Linux 3.7.1 and the software side changed somewhat.
> > windfarm_rm31 seems to no longer calm the fans down once loaded,
> > whereas therm_pm72 on Linux 3.0 did so.
> 
> Hrm, that would be a bug ... unfortunately I never got to test it
> properly due to my xserve being dead.

I booted a Xserve today with 3.11-rc1, and noticed the noise is coming
from slots-fan (PCI fan?) which is always 99%, although the slots-temp is
just 33. Is it on purpose the rm31 slots PID params are totally different
from therm_pm72 slots params? It seems like they have been copied from
pm72 "drive bay" PID params instead.

A.
