Date: Wed, 10 Dec 2003 14:44:56 +0100
Message-ID: <3FBD5348000908B4@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <001801c3bf1f$30180dc0$4844900a@hydingnb1>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: Re: RAMDISK: incomplete write (ramdisk too small?)
To: "hyding" <nari_dhy@nari-china.com>,
	"ARIBAUD Albert" <a.aribaud@giat-industries.fr>
Cc: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

the following links might be useful on how to build a
ramdisk image containing a working Linux root file
system:

http://www.denx.de/twiki/bin/view/DULG/AddingFilesToRamdiskIsNonPersistent
http://www.linuxdevices.com/articles/AT5955697568.html

Good luck.

Wolfgang.


>-- Original Message --
>From: "hyding" <nari_dhy@nari-china.com>
>To: "ARIBAUD Albert" <a.aribaud@giat-industries.fr>
>Cc: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
>Subject: Re: RAMDISK: incomplete write (ramdisk too small?)
>Date: Wed, 10 Dec 2003 21:11:56 +0800
>
>
>
>hi, Albert
>    Thanks a lot.
>    It doesn't complain now and mounts initrd now. But it still has some
>problem.
>    It immediately umount initrd and mount disk fs. I think there is no
program
>in ramdisk. I only installed busybox into the ramdisk.
>    What more is needed to make up of the ramdisk.
>Thanks!
>
>----- Original Message -----
>From: "ARIBAUD Albert" <a.aribaud@giat-industries.fr>
>To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
>Sent: Wednesday, December 10, 2003 4:30 PM
>Subject: RE: RAMDISK: incomplete write (ramdisk too small?)
>
>
>>
>> > -----Message d'origine-----
>> > De : owner-linuxppc-embedded@lists.linuxppc.org
>> > [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part
>> > de hyding
>> > Envoyé : mercredi 10 décembre 2003 02:51
>> > À : linuxppc-embed
>> > Objet : RAMDISK: incomplete write (ramdisk too small?)
>> >
>> >
>> >
>> > hi,all
>> >     I made an initrd but failed to boot.The process about making the
>> > initrd is as follows:
>> >     dd if=/dev/zero of=/tmp/ramdisk.image bs=1k count=8192
>>
>> Looks like you're building a ramdisk bigger than 4megs.
>> The kernel need a RAMDISK_SIZE=8192k command line argument for your
>> 8meg ramdisk to work, I think.
>>
>> Albert.
>>
>>
>>
>>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
