Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AB63EEA.987DC654@esd-electronics.com>
Date: Mon, 19 Mar 2001 18:16:26 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flash writing with Linux
References: <200103161525.HAA26938@shell9.ba.best.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Subodh,

Subodh Nijsure wrote:
>
> Perhaps you can take a look at mtd and use that to manage your flash.
> With mtd you can partition your flash to different devices and erase them
> selectively.
What is mtd ? Never heard of before !
>
> Once you have your flash partitioned you can simply cat a file to /dev/mtd#
> to copy new content to the flash.
That sounds nice and seems to be same like the stuff Wolfgang offered in
his 2.4.3-preX patch.

Matthias


--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
