Message-Id: <4.2.2.20040519134735.04c20180@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 13:52:25 -0700
To: Eugene Surovegin <ebs@ebshome.net>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics
Cc: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040519211929.GB13351@gate.ebshome.net>
References: <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
 <4.2.2.20040519123513.05074da0@bhawley.mailhost.luminex.com>
 <4.2.2.20040519132218.050b0df0@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>Actually, a lot of people succefully boot Ebony using stock IBM boot
>loader (me
>included)
>
>Please, post boot log for the _default_ Ebony configuration (using IBM
>bootlader
>_not_ u-boot and build with ebony_defconfig), maybe we can help you.

We're in the process of trying to get the IBM bootloader to work.  We think
perhaps
what came with the board from the vendor was somehow not correct.  So, we
are trying to find another source for the IBM bootloader that we can flash.

The ebony_defconfig doesn't have support for initrd, and since, at present,
the EMAC
driver seems to only find ff:ff:ff:ff:ff:ff as the Mac address, we aren't
able to boot over
the network [ ebony_defconfig default bootargs ].

Am I correct in assuming that u-boot will not be capable of booting linux
on the ebony
regardless?  It does appear to boot linux okay, but we haven't been
successful in getting
it to mount the ramdisk [ which is in u-boot format -- although we've also
tried just the ramdisk_image.gz
and pRamdisk directly tftp'd into memory ].  And, with the network MAC
address issue, we haven't
had any luck with the network stuff either.

Thanks for offering assistance.

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
