Message-ID: <000601bfb7c9$d40a0840$0201a8c0@home>
From: "Jeff Millar" <jeff@wa1hco.mv.com>
To: "Jim Lewis" <jlewis@mvista.com>, "Mike Flynn" <mike.psc@connectnet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <001101bfb74c$90881c60$5e621018@elcjn1.sdca.home.com> <3914446F.C653F97A@mvista.com>
Subject: Re: RAM disk size
Date: Sat, 6 May 2000 22:13:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We had some trouble with ramdisk larger than 4096K when used as initial
ramdisks.  Don't remember if they have problems when just created, mounted
and used.  This occured with the Dan Malek kernels from late 1999, don't
know if MontaVista has addressed this issue.  The symptoms were that the
creation went fine but caused mysterious failures when mounted during boot.

jeff

----- Original Message -----
From: "Jim Lewis" <jlewis@mvista.com>
To: "Mike Flynn" <mike.psc@connectnet.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, May 06, 2000 12:12 PM
Subject: Re: RAM disk size


>
> Hello Mike,
>
> The default max ramdisk size is 4096K. You can change this using the
> ramdisk_size boot parameter. You will definitely need to change this
default on
> the target.
>
> On the host, another way to create a ramdisk image is to use the loopback
> filesystem. This will allow you to avoid having to change the Ramdisk-size
of
> your development host. Take a look at the Loopback-Root-FS How-To.
>
> -Jim
>
> Mike Flynn wrote:
>
> > I need to flash an image larger than 4 megs to an Embedded Planet RPX
CLLF
> > (860T) board with 8 MB of flash. I'm having a problem making a RAM disk
file
> > image larger than 4 MB on a LinuxPPC host preceding the download to the
> > target:
> >
> > mkfs -m 0 /dev/ram XXXX
> > or
> > mke2fs -c /dev/ram XXXX
> >
> >  with XXXX anything more than 4000 returns the following message:
> >
> > "Filesystem larger than apparent filesystem size.
> > Proceed anyway? (y,n)"
> >
> > Proceeding "anyway" seems to work until any activity that would put more
> > than 4 MB in /dev/ram (mounted as /mnt) yields:
> >
> > "No space left on device"
> >
> > How do I get beyond this host limitation to use more of the available
flash
> > on the CLLF board?
> >
> > Thanks,
> > Mike Flynn
> > Enerdyne Technologies
> >
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
