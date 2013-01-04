Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D4BDB2C008E
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2013 15:09:02 +1100 (EST)
Message-ID: <1357272527.2500.18.camel@pasglop>
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert Berger <robert.karl.berger@gmail.com>
Date: Fri, 04 Jan 2013 15:08:47 +1100
In-Reply-To: <50878089.6060301@gmail.com>
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
 <50802F4C.3000309__36526.1883860969$1350578085$gmane$org@gmail.com>
 <50804020.30505@gmail.com>
 <1350587006.2476.12.camel__24873.815305955$1350587085$gmane$org@pasglop>
 <50841653.4050301@reliableembeddedsystems.com>
 <1350849666.2476.138.camel__11705.9888471433$1350849778$gmane$org@pasglop>
 <50878089.6060301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, rsarmah@apm.com, mla@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-10-24 at 08:45 +0300, Robert Berger wrote:
> Hi Ben,
> >
> > Remind me what is the symptom ? A specific device isn't working ? Or the
> > whole kernel goes toast ?
> 
> The whole kernel goes toast! Just reboots without saying much before;)
> 
> > My feeling is that those patches make MSIs
> > work (well that's what they are supposed to do) and for some reason that
> > doesn't agree with whatever you have connected to the PCIe slot...
> 
> I have nothing connected to the PCIe slot. Just a standard kilauea eval
> board with a defconfig and a 3.6 kernel, so if someone has a kilauea
> board it should be very easy to reproduce.
> 
> Mai, Rupjyoti do you have a kilauea bard lying around to test?
> 
> Maybe it's the kilauea fdt?
> 
> If I hard code NR_MSI_IRQS (as it used to be) at least the kernel boots
> and I can work with the board. (I don't think MSI interrupts work).

Mai ? Somebody else from APM ? Can you look at this ?

Ben.
