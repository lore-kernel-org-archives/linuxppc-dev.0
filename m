From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE77770F@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question about ramdisk. 2
Date: Mon, 29 Sep 2003 17:14:17 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I also tried this.
under host :
genromfs dir -o test.img ~/Test   -> build a romfs file with my application
then
mkcramfs ..... -> build a cramfs that contains the test.img.
Then I flash the cramfs on my target...

On the target
dd -if /bin/test.img -of /dev/rd/0
mount -t romfs /dev/rd/0 /test

And in /test I find my application. Exactely what I need

So I would to do this but without flashing.
So I need to replace "dd -if /bin/test.img -of /dev/rd/0" by something done
only with the help of BDM...

Any ideas ?


Thanks.

> -----Message d'origine-----
> De : Christophe.LINDHEIMER@fr.thalesgroup.com
> [mailto:Christophe.LINDHEIMER@fr.thalesgroup.com]
> Envoyé : lundi 29 septembre 2003 16:08
> À : linuxppc-embedded@lists.linuxppc.org
> Objet : Question about ramdisk.
>
>
>
> Hi.
>
> I am using where linux is running in flash.
> I would like to use a ramdisk to develop my application.
> So I make mount -t ramdisk /dev/rd/0 /rdisk to get my ramdisk.
>
> The application is developed on my host computer and the only
> link between
> the board and the host is my Bdi2000.
>
> So I would like to copy my cross compiled application into
> the ramdisk on my
> target.
>
> Is there a way to do that ?
>
> I guess that I need to know the @ of the ramdisk ?
> How can I get it ?
>
> Thanks
>
> Regards
>
> Chris
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
