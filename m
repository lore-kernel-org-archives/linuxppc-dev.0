Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp10.wanadoo.fr (smtp10.wanadoo.fr [193.252.22.21])
	by ozlabs.org (Postfix) with ESMTP id 141AF2BF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 04:30:39 +1100 (EST)
Date: Wed, 5 Jan 2005 18:39:08 +0100
To: Christian <evilninja@gmx.net>
Message-ID: <20050105173908.GC29131@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501041504.57588.marvin24@gmx.de>
	<1104850036.6164.25.camel@weizen.left.earth>
	<200501051233.25622.marvin24@gmx.de>
	<20050105154753.GA26760@pegasos> <41DC1F7E.5030003@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41DC1F7E.5030003@gmx.net>
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

On Wed, Jan 05, 2005 at 06:10:22PM +0100, Christian wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Am Dienstag, 4. Januar 2005 15:47 schrieb Sebastian Heutling:
> >>
> >>>Hello again Marc,
> >>>
> >>>
> >>>>>>Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I
> >>>>>>can write it to a floppy disk)?
> >>>>>
> >>>(...)
> >>>It is on: http://sengor.ath.cx/~sheutlin/prep/zImage.prep
> >>
> 
> yes, it's booting, but i get timeouts here on my PReP (however Marc says,
> that he does not get errors). would you be so kind and publish the .config
>  too?
> 
> > Did you try : 
> > 
> >   http://people.debian.org/~luther/prep/d-i-2005.01.03-prep
> > 
> 
> and Sven: nice d-i, really. but i couldn't see any config for this kernel
> either. it would be nice if you could put the config somewhere too.

It is the standard powerpc debian kernel. apt-get install
kernel-image-2.6.8-powerpc, and you will find the config in
/boot/config-2.6.8-powerpc. All the rest of the stuff can be found in the
debian kernel svn repo : 

  http://svn.debian.org/wsvn/kernel/trunk/kernel/

> mine are here, now with SCSI enabled too and thus errors showing up:
> 
> http://www.nerdbynature.de/bits/hal/daily/configs/config-ppc-2.6.10
> http://www.nerdbynature.de/bits/hal/daily/boot/dmesg-2.6.10
> 
> (but network is fine now ;-))

Well, i am really interested to know if the above debian kernel boots for you
or not. And to find the patches that fix it if it doesn't.

Friendly,

Sven Luther
