Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C99FCB2.8050109@thales-bm.com>
Date: Thu, 21 Mar 2002 16:30:58 +0100
From: Julien Eyries <julien.eyries@thales-bm.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MBX boot loader on a MPC8260 custom board
References: <20020321111807.9BC64109F3@denx.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang,


first let me thank you for your help
we have found the reason for our problem :
it was some specific ADS8260 code which crashe the CPU
on our board . we just had to removed it to have the kernel booting.
even if we see the kernel hanging up a few time latter,
while initializing the FEC , we are now very very happy to see some log
messages from the kernel on the console !!!


>
> Well, my recommendation is to get rid of all this stuff in the mbxbot
> directory and use PPCBoot as  firmware  instead;  but  I'm  obviously
> biased, and YMMV.

Yes  :-) . i had a look at PPCboot which i m sure is very cool ;
and seems to support a lot of commercial boards.

anyway for the moment, it is just O.K. for us if we can do all the
things we have to do, like loading our code via TFTP, debugging and so
on by using our BDI-2000 probe.


Greetings,

Julien.




--
Julien Eyries
R&D engineer
Thales Broadcast & Multimedia (ex-thomcast)
email: julien.eyries@thales-bm.com
fax: 33(0) 1 34 90 31 10
tel: 33(0) 1 34 90 31 01


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
