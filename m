Message-ID: <3FB391BA.3020600@primagraphics.co.uk>
Date: Thu, 13 Nov 2003 14:14:18 +0000
From: Mark Powell <medp@primagraphics.co.uk>
MIME-Version: 1.0
To: Laurent Mohin <laurent.mohin@acterna.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Silicon Motion VGA controllers and PPC architecture
References: <OFD7959B2B.BABE0C63-ONC1256DDD.002D77C3-C1256DDD.002D7E99@se.wavetek.com>
In-Reply-To: <OFD7959B2B.BABE0C63-ONC1256DDD.002D77C3-C1256DDD.002D7E99@se.wavetek.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Mohin wrote:

>You will find a driver for it on u-boot and also a framebuffer driver in
>Linux (at least in 2.4.20 if I remember well). You will also find an
>accelerated driver for Xfree (I haven't tested it yet).
>
>
Xfree driver doesn't work without BIOS, it uses BIOS calls to program
video mode etc.
There is code in the driver to do the same jobs but it doesn't work.

I didn't know there was a driver in U-boot - that is interesting,
thanks. I have been using an earlier version of PPCBoot.
Mark

--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
