MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16155.57953.711771.629231@cargo.ozlabs.ibm.com>
Date: Mon, 21 Jul 2003 08:53:53 -0400
From: Paul Mackerras <paulus@samba.org>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Radeon problems
In-Reply-To: <20030719145532.20ff05e3.pochini@shiny.it>
References: <20030719145532.20ff05e3.pochini@shiny.it>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini writes:

> I have a dual G4-mdd with a r9000 and I'm using
> Linux Jay 2.4.22-pre6 #4 SMP sab lug 19 08:29:11 UTC 2003 ppc unknown
>
> Problem #1: Radeonfb sets a video mode that isn't supported by my LCD
> monitor. I have to blindly type "/usr/sbin/fbset -a 1280x1024-60 -depth 16"
> at the root console every time (*if* it boots, because I make the box crash
> quite often :( ). Is there a boot option to set the right video mode ?

With a 2.5 kernel I use video=radeonfb:dfp quite successfully.  With
2.4 I think you have to say video=radeon:dfp (without the "fb").

> Problem #2: I've managed only to use X in fbdev mode at 16bits. No way to
> use the radeon driver.  Any hint ?
> [XFree86 Version 4.2.0 (echo Yellow Dog Linux release: 4.2.0-6.30e) / X Window System]

I have been using radeonfb together with Michel Daenzer's X server and
DRI modules very successfully for a while now.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
