To: Dan Malek <dan@mvista.com>
Cc: Kevin Fry <kevin@carts.com>, Laura Dean <tralad@yahoo.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ramdisk for rpx-lite 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Apr 2001 17:56:01 EDT."
             <3AEDDF71.28439605@mvista.com>
Date: Tue, 01 May 2001 00:21:26 +0200
Message-Id: <20010430222131.9EAC32814D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AEDDF71.28439605@mvista.com> you wrote:
>
> Kevin Fry wrote:
> >
> > I too am looking for a pre-setup ramdisk .  But I'm looking for the one
> > mentioned that exists for Monta Vista. 2.4.0 kernel.
>
> I don't know who would have mentioned such a thing, because I'm not
> aware of one.  I just install a few of the RPMs, strip the libraries,

We have an example ramdisk image on our FTP server (to be  used  with
PPCBoot, but you can strip off the 64 byte header easily:
	dd if=SIMPLE-PPCBOOT-ramdisk of=ramdisk.image.gz bs=64 skip=1
);  see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SIMPLE-PPCBOOT-ramdisk

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To be a winner, all you need to give is all you have.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
