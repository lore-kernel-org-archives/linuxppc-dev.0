Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id B98C32BF13
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2005 03:18:16 +1100 (EST)
Date: Thu, 6 Jan 2005 17:27:11 +0100
To: Christian <evilninja@gmx.net>
Message-ID: <20050106162711.GA32598@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de>
	<20050105154753.GA26760@pegasos> <41DC1F7E.5030003@gmx.net>
	<20050105173908.GC29131@pegasos> <41DD60A3.3020203@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41DD60A3.3020203@gmx.net>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 06, 2005 at 05:00:35PM +0100, Christian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Sven Luther schrieb:
> > 
> > It is the standard powerpc debian kernel. apt-get install
> > kernel-image-2.6.8-powerpc, and you will find the config in
> > /boot/config-2.6.8-powerpc. All the rest of the stuff can be found in the
> [...]
> > 
> > Well, i am really interested to know if the above debian kernel boots for you
> > or not. And to find the patches that fix it if it doesn't.
> 
> ok. but 2.6.8 +2.6.9 won't boot for me, as it does not include the
> prep_pci.c fix, which was introduced in 2.6.10-rc3. i assume

Sure, and backported to the debian kernel.

> http://people.debian.org/~luther/prep/d-i-2005.01.03-prep
>
> is made from a current kernel, thus containing the fix (because it's
> booting, upon "configure network" the network actually works too ;))

Nope, same kernel-source-2.6.8 based one as will ship with sarge. It is not
uploaded yet, will probably be uploaded this WE.

> i've fetched kernel-source-2.6.9 now, applied the prep_pci fix and
> compiled the kernel. i *had* to make changes to the debian-config
> (config-2.6.9-powerpc) because i am still not able to boot via disk. so i
> enabled CONFIG_ROOT_NFS and CONFIG_TULIP, details here:

These should be enabled by default in the debian config though :/

> http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc
> http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc.my
> http://www.nerdbynature.de/bits/hal/2.6.10-rc3/prep_pci_renumbered-2.6.10-rc3.patch
> 
> the kernel boots, network is set up, but since everything else is modular,
> it cries about several things. i can ping the host and i really think this
> all would work, except when i set CONFIG_SCSI_SYM53C8XX_2=y
> 
> http://www.nerdbynature.de/bits/hal/daily/boot/config-2.6.9-powerpc.my+scsi
> 
> then the ABORT and RESET errors show upon upon initialization of the
> scsi-adapter (no disk attached). i don't have a fix for this scsi-issue at
> hand. maybe i missed something...

Mmm, it works well here, so maybe your scsi hardware has some problems ? 

> hope this helps anyhow to get PReP ready for debian sometimes...
> Christian.

Well, prep on powerstack will be easy, the others will depend on people
submiting a kernel patch for them ? 

Friendly,

Sven Luther
