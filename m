Message-ID: <37A01A3D.E9A83C73@agelectronics.co.uk>
Date: Thu, 29 Jul 1999 10:09:17 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: G3 Upgrade Questions....
References: <XFMail.990728151208.jeremy@goop.org> <lcr9lsqd0d.fsf@yamato.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Takayuki Yamaizumi wrote:
>   I have also created another patch, but not polished :-) This patch
> is relative to the latest 2.2.10 vger kernel.
> 
>   It works like the following on my PowerBook G3 (266MHz/14.1inch
> screen), but I can't check CPU's "real" tempetature, I am not sure
> this value is correct.

I'm a little confused by this patch, because it is very different from
Motorola's application note AN1800/D (Programming the Thermal Assist
Unit in the MPC750 Microprocessor). 

http://www.mot.com/SPS/PowerPC/teksupport/teklibrary/appnotes/an1800.pdf

1) No calibration. The board vendor is supposed to calibrate the TAU
before shipping the board, then supply the calibration value. I'm not
sure whether Apple do this.
2) Why all the time spent doing bit reversals? Why not just fix the
broken values in processor.h and test the correct bits to start with?

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
