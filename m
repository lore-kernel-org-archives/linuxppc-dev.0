To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	yellowdog-devel@lists.yellowdoglinux.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI Radeon 32MB PCI, Apple 17 Flat panel on B+W G3
References: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
From: gtgj@pacbell.net (Gregorio Gervasio Jr.)
Date: 07 Oct 2001 10:16:21 -0700
In-Reply-To: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
Message-ID: <m3wv27weu2.fsf@adsl-63-196-7-33.dsl.snfc21.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> On Sat, 06 Oct 2001 18:37:24 -0700 (PDT), Ani Joshi <ajoshi@shell.unixbox.com> said:

a> Ben's kernel tree has a relatively recent version of radeonfb, I will
a> send out an updated newer version in a couple days.  As for X, you can
a> build 4.1.0 and apply the patch I have in my dir on ftp.linuxppc.org
a> (users/ajoshi/radeon) or you can build X cvs which has my fixes applied.
a> DRI support is still in progress.

a> Flat panel support in radeonfb will be nice, I will try and send you some
a> code over for that as I do not have a flat panel display.

        What is supposed to be missing as far as flat panel support is
concerned?  I just got the same Radeon card connected to a Samsung
flat panel and it seems to work (in digital mode).  I'm using Ben's
rsync kernel (2.4.11-pre4-ben0) with Fukui-san's XFree86 4.1.99
RPM's. I have an old world machine though, so I use BootX to boot.

        By the way, how do you specify the video mode at boot time?  I
had to change the default video mode in radeonfb.c to 1280x1024-8@61
since the Samsung doesn't seem to like 640x480-8@60.
--
Gregorio Gervasio, Jr.
gtgj@pacbell.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
