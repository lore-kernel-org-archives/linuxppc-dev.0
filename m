Return-Path: <stuart.yoder@conformative.com>
Received: from relay3.mail.twtelecom.net (relay3.mail.twtelecom.net
	[216.136.95.10]) by ozlabs.org (Postfix) with ESMTP id 17DDF67B1B
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 00:54:28 +1000 (EST)
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "'linuxppc-dev list'" <linuxppc-dev@ozlabs.org>
Date: Tue, 26 Apr 2005 09:54:10 -0500
Message-ID: <054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1114486594.7183.12.camel@gaston>
Subject: RE: PowerPC + SMP
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks Ben.

That raises a question though-- how can I know what assumptions the
kernel makes about the state of the CPU/system when it begins execution?
Is this clearly documented anywhere?

I am using U-boot on my SMP system and U-boot is not SMP aware.  Do you
know of other open source bootloaders for Linux that would set up the
CPUs as the kernel expects.

Thanks,
Stuart Yoder


> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org] 
> Sent: Monday, April 25, 2005 10:37 PM
> To: Stuart Yoder
> Cc: linuxppc-dev list
> Subject: Re: PowerPC + SMP
> 
> 
> On Mon, 2005-04-25 at 16:11 -0500, Stuart Yoder wrote:
> > Hi.
> >  
> > I am trying to figure out where in the PowerPC kernel the HID1 
> > register is updated to enable bits dealing with cache 
> coherency in an
> > SMP system.   Grepping through the arch/ppc source does not reveal
> > much.
> >  
> > I have two 7447A processors and somewhere the ABE and 
> SYNCBE bits need
> > to be turned on to enable cache coherency.   Is supposed to 
> happen in
> > the bootloader prior to the kernel running??
> 
> It's usually expected to happen in the firmware yes, though 
> the kernel does some of it's own 'fixups' (look at setup_cpu_6xx.S)
> 
> Ben.
> 
> 
> 
> 
> 
