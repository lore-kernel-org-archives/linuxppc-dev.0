Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A6F6DDEF5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 08:07:28 +1000 (EST)
Message-ID: <464397B8.408@genesi-usa.com>
Date: Thu, 10 May 2007 23:07:52 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
References: <200705092203.26042.rob@landley.net>
	<20070510172806.GE4452@austin.ibm.com>
In-Reply-To: <20070510172806.GE4452@austin.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

QEMU really really wants a PREP kernel, and that stuff's just not in the new
arch/powerpc tree anymore is it?

I'd love to see the device tree once QEMU's kernel has booted :D

I wonder.. would it be useful to have a qemu platform in arch/powerpc and
for someone to start hacking in devices from a non-emulated point of view?
It seems a bit of a waste in my mind to emulate a network card, serial port
IDE interface, ADB (yick!) and a VESA graphics adapter in such 'detail' when
it can be passed back to the emulation somehow through some kind of clever
call interface (maybe just have the zero page of the emulation contain a
bunch of 'ports' which are really function calls pointers..?)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Linas Vepstas wrote:
> Hi Rob,
> 
> On Wed, May 09, 2007 at 10:03:25PM -0400, Rob Landley wrote:
>> I've been puttering around with my Firmware Linux project trying to add
>> powerpc as a supported platform.  I can build kernels that qemu can boot (such
>> as a "prep" kernel) using ARCH=ppc, but that one doesn't support make
>> headers_install.
>>
>> Using ARCH=powerpc makes headers_install work, but there's no kernel .config 
>> I've been able to come up with that generates a kernel I can boot under qemu.
> 
> Hmm. I'm not a boot expert, (although many people on this list are). 
> Any hint of where the boot is failing?  Maybe qemu is not setting up
> a device tree? 
> 
>> what's the status of the 
>> ppc->powerpc migration, 
> 
> pretty far along; bits f ppc are getting nuked regularly.
> 
>> and is there any known way to get ARCH=powerpc to 
>> build a kernel qemu can boot?
> 
> Dunno...
> 
> --linas
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
