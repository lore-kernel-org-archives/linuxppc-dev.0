Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
Date: Thu, 18 Dec 2003 17:32:13 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: wdt_mpc8xx documentation
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FE12DCD.10609@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings

Whilst rummaging about the PPC development tree I came across the
Siemens/SGI/Denx watchdog driver for the mpc8xx. It references a man
page which so far I've not been able to find (man wdt_mpx8xx(4)) so I'm
a bit clueless about what the monitor chain code does.

It doesn't seem to relate to the generic watchdog_api.txt in the kernel
documentation (at least the defines don't seem to tie in with any of the
  ioctl options).

Any help here appreciated.

--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
