Message-Id: <200007061657.SAA21598@denx.local.net>
To: Tom Roberts <tjroberts@lucent.com>
cc: Ruedi.Hofer@ascom.ch, linuxppc-embedded@lists.linuxppc.org
Subject: Re: newlib, uclib 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Jul 2000 09:26:33 CDT."
             <39649719.6A828478@lucent.com>
Date: Thu, 06 Jul 2000 18:57:13 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <39649719.6A828478@lucent.com> Tom Roberts wrote:
>
> Ruedi.Hofer@ascom.ch wrote:
> > In order to build a commercially successful product I have to reduce the footprint of the system.
> > Having a quick look at the files showed me, that the largest files are the libs (libc.so.6 = 4M) ... as u all know.
>
> Initially I also thought I would have to strip down the libraries
> to reduce their footprint. But then I realized that Linux is a demand-
> paged system, and only the pages which actually get used will be
> loaded into memory. In our case only memory is an issue, the disk
> space required is not important. So making libc include _everything_

You have a disk, then.

Ruedi is probably on an embedded system, loading a compressed  initrd
image from Flash into a ramdisk.

Both flash and RAM are resources which get tight all too often.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How many hardware guys does it take to change a light bulb? "Well the
diagnostics say it's fine buddy, so it's a software problem."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
