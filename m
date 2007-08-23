Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 1D75ADDF62
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 18:24:39 +1000 (EST)
Message-ID: <46CD4444.4040602@dutchspace.nl>
Date: Thu, 23 Aug 2007 10:24:36 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Konstantin Boyanov <kkboyanov@gmail.com>
Subject: Re: Driver for device behind a PCI-VME bridge
References: <929bf310708200140w6efc57f6k81a1339845059e2d@mail.gmail.com>	
	<46C954AA.7050609@dutchspace.nl>	
	<929bf310708200158m3dab7669j56e4dbf2d84f17a@mail.gmail.com>	
	<929bf310708210055k3970c3chfc097ff776af439a@mail.gmail.com>	
	<929bf310708210056s2b699500x36c6b1ae83881496@mail.gmail.com>	
	<46CAA332.9060907@dutchspace.nl>	
	<929bf310708210249x3cf8342aq4523d2a895d78eb@mail.gmail.com>	
	<46CAE973.6040306@dutchspace.nl>
	<929bf310708230047n70bfe883gb963eba6e254b479@mail.gmail.com>
In-Reply-To: <929bf310708230047n70bfe883gb963eba6e254b479@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Konstantin Boyanov wrote:
> Hi again,
>  
> First of all thanks for reply.
>  
>
>     I attached a diff to the 3.7 version of the Motorola patch. I hope
>     this
>     will help you. This is not the Xenomai version, but the standard
>     version
>     with VME interrupts per level. The mechanism for Xenomai is identical,
>     but I don't know yet about the legal status of this. The attached
>     patch
>     has also been provided to Motorola.
>
>  
> I've got the 3.5 version of the driver, and tried to find newer one. 
> Where do you get this new releases and patches?
> Nevertheless thanks for the patch.

We got this patch directly from Motorola. Officially Motorola does not 
support Linux, but you can ask Ajit Prem (Ajit.Prem@motorola.com) for 
the latest version of the patch. As far as I know there is a patch 
availeble for 2.6.14 and 2.6.20, but as you have a patch for 2.6.15 
already it should not be to difficult to move the 2.6.14 patch to 2.6.15.

>
>     I also had some ssh problems, but AFAICR I had to enable
>     UNIX98PTYS and
>     BSDPTYS, and create the entries in /dev/ for the BSD ptys
>     (/dev/ttypXX
>     and /dev/ptyXX).
>
>  
> I also had these two options enabled, but still the kernel hangs at 
> boot time just after trying to initialize SCSI devices... Without 
> Xenomai this problem doesn't occur. I'm wondering what is that makes 
> Xenomai mess up things so badly?

I did not try SCSI on my system I just disabled all devices that I don't 
need, including SCSI. You could try disabling these devices for the 
moment (or build them as modules and load these later by hand) and see 
if that works, or that there are other problems.
If the problem is still there, you could try the Xenomai mailing list 
(see www.xenomai.org).

Kind regards,
    Johan Borkhuis

-- 
Johan Borkhuis                                  Dutch Space BV
email:        j.borkhuis@dutchspace.nl          Newtonweg 1
phone:        071-5245788                       Leiden
fax:          071-5245499                       The Netherlands
