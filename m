Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 48B182BF10
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 11:54:29 +1100 (EST)
Message-ID: <41D9E932.80605@gmx.net>
Date: Tue, 04 Jan 2005 01:54:10 +0100
From: evilninja <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>	<200412272237.57241.marc.dietrich@ap.physik.uni-giessen.de>	<1104625860.10369.34.camel@weizen.left.earth>
	<200501031326.34477.marvin24@gmx.de>
In-Reply-To: <200501031326.34477.marvin24@gmx.de>
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

Marc Dietrich schrieb:
> Hi Christian,
> 

actually, Sebastian is the helping hand here ;)

> Yes - a hard disk and a cdrom. Both are working under 2.4 kernels (see the 
> boot.log of the 2.4.24-pre1 kernel). I don't use net boot. My system (debian 
> sarge) is installed on sda3. Anyway - also on a netboot system, the kernel 
> should hang when trying to initialize the scsi controler.

i can't help you much at the scsi-issue here. as i said, i don't have a
disk attached to the machine any more. the last time i booted with disk
was a 2.4 kernel. and these errors (ABORT operation started / timed-out)
occured upon heavy load on the scsi bus. i think i've never booted a 2.6
kernel with a scsi disk attached. but the errors look familiar :-(

> I setup a kernel using your config file and added vga console and offb and 
> removed the nfs drivers to get an image smaller then 1.44 Mb (I'm using 
> XFree86-3.3.6 with the cirrus 5664 card). This has the same effect than 
> before: scsi not working. 

:-(

> It seems, that this config is not for a 2.6.10 kernel. What kernel version are 
> you using? Maybe some bad things happened in newer kernels.

ironically, now that i am able to netboot the machine, i'm not *using* it
anymore. but i'm building PReP kernel everyday, results and a config-file
is here:

http://www.nerdbynature.de/bits/sheep/latest-kernel/

> Can you put a working zImage.prep somewhere on the web (<1.44 MB, so I can 
> write it to a floppy disk)? 

yes, i'll upload working zImage.prep + .config here:

http://www.nerdbynature.de/bits/sheep/prep/

> How does your boot.log looks like?

i'll upload a boot.log too.

Christian.
- --
BOFH excuse #78:

Yes, yes, its called a design limitation
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2ekxC/PVm5+NVoYRAs/MAKCGSNylixVnx6W20TIK/h5ALwivxQCfc9pi
IL8BTtzcpDTJ9KNwhixVqXc=
=ggNI
-----END PGP SIGNATURE-----
