Message-ID: <39340AC7.689BFF86@snmc.com>
Date: Tue, 30 May 2000 13:39:03 -0500
From: Daris Nevil <Daris.Nevil@snmc.com>
MIME-Version: 1.0
To: Tom Roberts <tjroberts@lucent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Do you have your minimum ramdisk image which can provide basic
 network services ?
References: <020e01bfc93f$5dc075c0$db52df8d@helsinki> <3934086C.87BF893@lucent.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

The quick-and-dirty way of enabling your loopback device
is:

    ifconfig lo 127.0.0.1

Daris

SiSIC Inc/SNMC
www.snmc.com

Tom Roberts wrote:

> SangTae Ha wrote:
> > I already downloaded full image file at > ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/mbxroot.full.tgz
>
> I just downloaded that file, too. As you say, it is HUGE (133 MB
> gzipped).
>
> Unfortunately, it is also incomplete. In particular, it is missing:
>         init            (/etc/telinit is a link to init, but no init)
>         inetd
>
> I had been hoping to simply build up an initrd image from selected
> pieces of it, because I now have the Linux kernel, console, and
> initrd-ramdisk up and running on my hardware (Hurrah!). But I'm
> having difficulty building a sufficient initrd image to actually use
> the network driver I have written (:-(). So far, I cannot even ping
> myself using the loopback device (no inetd, I suppose).
>
> Tom Roberts     tjroberts@lucent.com
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
