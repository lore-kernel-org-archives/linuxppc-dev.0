From: "Stefano Coluccini" <s.coluccini@caen.it>
To: <ghannon@cspi.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MVME5100 booting from SCSI disk
Date: Thu, 14 Feb 2002 09:24:01 +0100
Message-ID: <NDBBIFIMCKPOADMAJOKMCEFCEAAA.s.coluccini@caen.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <85256B5F.00553845.00@pine.cspi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


HI,
  I can confirm to you that booting from network and using a HD partition as
root filesystem works correctly. I haven't tried yet to boot from HD, but
I've read something interesting about this argument in the ppcbug manual at
the GEVBOOT command and the PBOOT command.

I hope this can help you.
Bye.

+--------------------------------------------------------+
! Stefano Coluccini         ! CAEN Engineering srl       !
! Via Vetraia, 11           ! 55049 Viareggio (LU)-ITALY !
! Tel. +39 0584 388 398     ! Fax +39 0584 388 959       !
! s.coluccini@caen.it       ! www.caen.it/computing      !
+--------------------------------------------------------+


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> ghannon@cspi.com
> Sent: Wednesday, February 13, 2002 5:31 PM
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: MVME5100 booting from SCSI disk
>
>
>
> I'm trying to find documentation on getting a Motorola 5100 board to boot
> from a
> hard drive.    What I spefically am wondering is do I need a
> "boot loader",
> or is that
> built into the kernel?
>
> I can build a kernel (2.4.11) which works and until now have been using a
> ROMFS, built into
> zImage.initrd.pplus.  I am currently able to netboot or boot from flash.
>
> I am thinking I can rebuild this kernel root=/dev/sda7 and I
> should be able
> to get it
> to use the hard drive as /.  My question is can I just put that new kernel
> on a
> bootable partition on the hard drive and get PPCbug to boot from that
> partition, or do I need
> some form of a bootloader?  (yaboot, lilo, other)    I do realize I should
> be able to
> flash this kernel and then have the board boot from flash and use
> the drive
> as /.
> Is this the more common approach?
>
> If there is a good write up on this I would be glad to read about it, I
> just haven't found it yet.
> I do have the PPCbug manuals.
>
> Thanks,
> Gary Hannon
> CSPI
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
