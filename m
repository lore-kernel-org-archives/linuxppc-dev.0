Message-ID: <001801c3bf1f$30180dc0$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "ARIBAUD Albert" <a.aribaud@giat-industries.fr>
Cc: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
References: <158EF4B20EA8C84D9DC71A55216D2E1C066C54@csy-exchange1.giat.intra>
Subject: Re: RAMDISK: incomplete write (ramdisk too small?)
Date: Wed, 10 Dec 2003 21:11:56 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi, Albert
    Thanks a lot.
    It doesn't complain now and mounts initrd now. But it still has some problem.
    It immediately umount initrd and mount disk fs. I think there is no program in ramdisk. I only installed busybox into the ramdisk.
    What more is needed to make up of the ramdisk.
Thanks!

----- Original Message -----
From: "ARIBAUD Albert" <a.aribaud@giat-industries.fr>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, December 10, 2003 4:30 PM
Subject: RE: RAMDISK: incomplete write (ramdisk too small?)


>
> > -----Message d'origine-----
> > De : owner-linuxppc-embedded@lists.linuxppc.org
> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part
> > de hyding
> > Envoyé : mercredi 10 décembre 2003 02:51
> > À : linuxppc-embed
> > Objet : RAMDISK: incomplete write (ramdisk too small?)
> >
> >
> >
> > hi,all
> >     I made an initrd but failed to boot.The process about making the
> > initrd is as follows:
> >     dd if=/dev/zero of=/tmp/ramdisk.image bs=1k count=8192
>
> Looks like you're building a ramdisk bigger than 4megs.
> The kernel need a RAMDISK_SIZE=8192k command line argument for your
> 8meg ramdisk to work, I think.
>
> Albert.
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
