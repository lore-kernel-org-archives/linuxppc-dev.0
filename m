Date: Sun, 14 Nov 1999 15:59:09 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: "Jens Ch. Restemeier" <jrestemeier@currantbun.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PMac Reverse engineering
In-Reply-To: <382EED76.1FD4695C@currantbun.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.991114155349.27558C-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 14 Nov 1999, Jens Ch. Restemeier wrote:

> Hi !
> 
> There are still some issues with my 5500 to write Linux drivers for,
> like the (software) modem, and the I2C bus in via-cuda to access the TV
> card stuff. I've been a little absent from Linux-PPC but want to fix
> these sometime.
> 
> Question: Is there any usefull freeware for MacOS to reverse engineer,
> what system calls an application does, and to disassemble system drivers
> ? Or is there somebody at apple who can be bugged to give out info ?

I'd recommend contacting the Apple Linux guy (Kevyn, was it?) first.  xmon
at ftp://dev.linuxppc.org/users/paulus/misc/xmon.bin is very useful, and
you always have MacsBug.  They are both powerful Mac OS binary debugging
tools.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
