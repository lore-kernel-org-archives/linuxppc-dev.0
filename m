Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6A10C2BF16
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 04:17:05 +1100 (EST)
Message-ID: <41DC1F7E.5030003@gmx.net>
Date: Wed, 05 Jan 2005 18:10:22 +0100
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>	<200501041504.57588.marvin24@gmx.de>	<1104850036.6164.25.camel@weizen.left.earth>	<200501051233.25622.marvin24@gmx.de>
	<20050105154753.GA26760@pegasos>
In-Reply-To: <20050105154753.GA26760@pegasos>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Dienstag, 4. Januar 2005 15:47 schrieb Sebastian Heutling:
>>
>>>Hello again Marc,
>>>
>>>
>>>>>>Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I
>>>>>>can write it to a floppy disk)?
>>>>>
>>>(...)
>>>It is on: http://sengor.ath.cx/~sheutlin/prep/zImage.prep
>>

yes, it's booting, but i get timeouts here on my PReP (however Marc says,
that he does not get errors). would you be so kind and publish the .config
 too?

> Did you try : 
> 
>   http://people.debian.org/~luther/prep/d-i-2005.01.03-prep
> 

and Sven: nice d-i, really. but i couldn't see any config for this kernel
either. it would be nice if you could put the config somewhere too.

mine are here, now with SCSI enabled too and thus errors showing up:

http://www.nerdbynature.de/bits/hal/daily/configs/config-ppc-2.6.10
http://www.nerdbynature.de/bits/hal/daily/boot/dmesg-2.6.10

(but network is fine now ;-))


thank you both,
Chrisitian.
- --
BOFH excuse #305:

IRQ-problems with the Un-Interruptible-Power-Supply
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3B9+C/PVm5+NVoYRAmjiAJ4hrZAtauVVUjR6cWj+7l70+4X+lgCg/RlD
rPCFIAeCt5eiGxTYplSDONk=
=9pzA
-----END PGP SIGNATURE-----
