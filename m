Message-ID: <39887524.829532BB@embeddededge.com>
Date: Wed, 02 Aug 2000 15:23:16 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Phuc Le <lmphuc@yahoo.com>
CC: Embedded Linux <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Installing PCMCIA hard disk on DVK MPC823
References: <001401bffcf8$1a391220$e573a7ca@saigonnet.vn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Phuc Le wrote:

> My name's Phuc Le. I am new on this field.

You are doing better than most people that claim to be experts.....

> message were displayed as below:
>
> ... ide_cs.o: unresolved symbol 'ide_register'
> ... ide_cs.o: unresolved symbol 'ide_unregister'

There have been lots of changes here recently, hopefully I can get
one of the MontaVista folks to explain the details.......

You need to at least configure CONFIG_BLK_DEV_IDE and
CONFIG_BLK_DEV_IDEDISK (whatever the proper questions are to set
these).  You have to be careful not to configure _too_ much, as
the 8xx port is a little sensitive to this (probing places where
it shouldn't).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
