Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <DEA23DB61B62D4118B5900508B323B84012CC7D5@OPENMAIL>
From: Jeremy Bowen <Jeremy.Bowen@opennw.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Problems with MMU: address translation for 0xXXXXXXXX failed 
Date: Thu, 15 May 2003 09:15:19 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Success!! Thanks for the replies. Here's a brief summary of what was
necessary to get things working.

> > I'm trying to get a BDI2000 (firmware v1.09) working in
> > order to debug a kernel module.
> > I'm using an Embedded Planet RPXlite MPC850 board running
> > kernel v2.4.20
> ...
> > Am I missing something obvious ? Is this the right way to
> > go about debugging
> > a loadable module ? Any help would be gratefully appreciated.
>
> There were a couple of changes  /  extensions  to  the  MMU  support.
> Firmware version 1.09 is pretty old (Aug 2001). You might want to try
> a  more  recent one.

OK. I couldn't find any firmware on the Abatron web-site but fortunately
I've been sent v1.12 from a friend. This seems to make all the difference.

I was able to make some minor progress with the addition of "PTBASE 0xF0" to
my config file (as suggested by Dan) however the key seems to have been the
upgraded firmware in the BDI2000.

I'm not entirely sure the soft breakpoints are working correctly yet (I
suspect they probably are) but anyway I can make sufficient progress using
hard breakpoints for now.

Thanks for the assistance.


--
Jeremy Bowen
Senior Software Engineer
OPEN Networks Ltd
Wellington
New Zealand

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
