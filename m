From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Date: Tue, 25 Jul 2000 18:30:57 -0500
Message-ID: <yam8241.2878.148063952@mail.lf-online.de>
In-Reply-To: <200007251558.QAA02148@hyperion.valhalla.net>
Subject: Re: sound again [was: Re: xf4 bug report]
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 25-Jul-00 schrieb Iain Sandoe:

Hi!

>can you do a 'dmesg' and find any lines which have "dmasound" in them?
>Or... are you using sound as modules?
>I assume you are using Ben's binary (pre10-ben2)?

I just checked the message. I was wrong about the DMA stuff... sorry...
it reads

modprobe: can't locate module sound
rc.sysinit: Loading Sound module failed

Sounds as if the module is missing... but I installed the modules
exactly how I found them on the site... and the kernel and system.map
also...

>OK - I'll do it later (just this once :-) I don't want to as a general rule
>- because I have to pay for download bandwidth -- if there's a general move

Well, same here...

>for people to want to download binaries - I'll have to beg some space on an
>ftp server...

>I can't just send you the binaries for the modules - because they wouldn't
>load against an un-patched 2.2.17pre10.

Ah...

>OK, OK, maybe I wasn't clear ==> the dmasound stuff has bits for several
>machines including some of the 68k ones...

Ah :)

>You can find this using "Display Name Registry" on the apple side [it's
>available on the Apple web site IIRC] look under davbus:sound.

Not sure if I know what you mean...

>- or by looking in the /proc/device-tree on the linux side (I hope -
>although, of course, this could be the root of the problem :).

Well, I found the /proc/device-tree... what to look for there ? There are
a lot of files and directories...

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
