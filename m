Date: Wed, 10 Dec 2003 09:30:52 +0100
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: RAMDISK: incomplete write (ramdisk too small?)
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Message-id: <158EF4B20EA8C84D9DC71A55216D2E1C066C54@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Message d'origine-----
> De : owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part
> de hyding
> Envoyé : mercredi 10 décembre 2003 02:51
> À : linuxppc-embed
> Objet : RAMDISK: incomplete write (ramdisk too small?)
>
>
>
> hi,all
>     I made an initrd but failed to boot.The process about making the
> initrd is as follows:
>     dd if=/dev/zero of=/tmp/ramdisk.image bs=1k count=8192

Looks like you're building a ramdisk bigger than 4megs.
The kernel need a RAMDISK_SIZE=8192k command line argument for your
8meg ramdisk to work, I think.

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
