Message-ID: <002201c46e56$c34fdb90$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>,
	"Linh Dang" <linhd@nortelnetworks.com>
References: <20040720071610.7BC31C109F@atlas.denx.de> <wn5vfgi9arw.fsf@linhd-2.ca.nortel.com>
Subject: Re: list of 2.6-related migration issues for embedded programmers?
Date: Tue, 20 Jul 2004 08:40:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> >> - I failed to see what in initramfs mechanism would prevent
> >> one from having "separated images which can be updated
> >> independently of each other."
> >
> > initramfs gets linked with the kernel into one image, similar to
>
> But you don't have to. What ever you can do with the good-old initrd
> image you can do with the new initramfs (really cpio archive)
> image. The main difference is the creation: genext2fs vs cpio.
>
> I just happen to use zImage.initrd (where ramdisk.image.gz is a cpio
> archive) in our project because it's the most appropriate for our
> situation.
>
> Regards
>
> --
> L.D.
>

So you can have a separate uboot image (from mkimage) that you can update
separately and it will get passed to the kernel on boot?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
