From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B2366B@penguin.adic.com>
To: egarcia@mail.communica.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Looking for Ebony u-boot
Date: Thu, 13 Feb 2003 05:44:18 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I recently installed u-boot on an ebony board. I will attach my bin for you.
It is u-boot-0.2.0. It is built with a hack to auto-boot in 5 seconds. Make
sure you hit return within five seconds to get to the u-boot prompt. I did
this so I wouldn't have to enter the boot command by hand every time I
booted.

It was built according to the howto instructions in the source README for
EBONY_config, and it was compiled using the ELDK tool-chain.

-- Brian

p.s. I will send a second email just to you, so as not to send the
attachment to the entire mailing list.

p.p.s. I had to (a) set mac addrs at 0xfffffe00 and then (b) in nvram to get
my kernel to successfully boot. These can both be done from the u-boot
prompt. Details on this are providing in the Denx ELDK documentation.


-----Original Message-----
From: ed garcia [mailto:egarcia@mail.communica.com]
Sent: Thursday, February 13, 2003 8:38 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Looking for Ebony u-boot


Hi,

I just received and IBM Ebony 440GP system.  I'd like to get it going using
U-Boot.  Can anyone point me to an "already built" binary I can program onto
the board??  I will be doing the other route as soon as I can set up another
Linux box with the proper environment to build the sources.  I'm trying to
do a couple of things in parallel ...

Thanks for any help !!!

Regards

Ed Garcia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
