Message-ID: <37CFF4F1.774CA038@jlc.net>
Date: Fri, 03 Sep 1999 12:18:57 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Richard Hendricks <ra6353@email.sps.mot.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of MPC823FADS port?
References: <37CFECB2.9064DD78@email.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Richard Hendricks wrote:
> 
> Hello,
>   I was just curious as to the status of the MPC823FADS port of
> LinuxPPC.  I am interested in the video portion.  I wrote the video demo
> driver on Motorola's website, and would love to help.


I don't recommend using any (F)ADS board with Linux/PPC.  Trying
to set up the hardware and download a kernel is a horrible
experience.  You spend all of your time creating development
tools and none of it developing any application software.

The quality control of (F)ADS boards seems poor as well.  I have
spent weeks tracking down weird software bugs only to find some
hardware problem, usually out of spec signals on the board.  I
use the board next to it and it works fine.

With high quality boards available from a variety of sources
today, there is no need for the agony of using a (F)ADS board.

I am working on some video interfaces for other 823 boards.
I have a bunch of LCD screens that I have to prove to work with
the 823.

I will keep you posted.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
