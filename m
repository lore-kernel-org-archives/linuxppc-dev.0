From: "Calum Selkirk" <cselkirk@xs4all.nl>
Date: Sat, 19 Jul 2003 18:20:22 +0200
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon problems
Message-ID: <20030719162022.GB2427@xs4all.nl>
Reply-To: Calum Selkirk <cselkirk@xs4all.nl>
References: <20030719145532.20ff05e3.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030719145532.20ff05e3.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


* Giuliano Pochini [pochini@shiny.it] [2003-07-19 14:55 +0000]:

these really belong on linuxppc-user, still ..

> Problem #1: Radeonfb sets a video mode that isn't supported by my LCD
> monitor. I have to blindly type "/usr/sbin/fbset -a 1280x1024-60
> -depth 16" at the root console every time (*if* it boots, because I
> make the box crash quite often :( ). Is there a boot option to set the
> right video mode ?

video=radeonfb:1280x854-8@60

thats at 8bit but you shouldn't need higher for console.

> Problem #2: I've managed only to use X in fbdev mode at 16bits. No way
> to use the radeon driver.  Any hint ?

no idea about YD, nor the configuration of your kernel, nor your
XF86Config, but 24bit should be possible.

best

cal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
