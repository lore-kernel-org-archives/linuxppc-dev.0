Message-Id: <200007251558.QAA02148@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 16:58:42 +0100
Subject: Re: sound again [was: Re: xf4 bug report]
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tue, Jul 25, 2000,  Steffen Haeuser wrote:
> Am 25-Jul-00 schrieb Iain Sandoe:
[...]
> during bootup concerning sound came first with the new kernel (something about
> dma
> it said... if that helps I can look up the exact error message...).

can you do a 'dmesg' and find any lines which have "dmasound" in them?
Or... are you using sound as modules?
I assume you are using Ben's binary (pre10-ben2)?

>>I did a back-port of the 2.4.0-test4 dmasound stuff to 2.2.17pre10-ben2
>>(will check on pre13-ben1 later):
>>http://www.drfruitcake.com/linux/linuxppc.html
>
> I guess the dmasnd-v2a.patch is the file to get ? Hmmm, is there also a Binary
> Version available somewhere ? I do not have the latest Kernel Source on my
> machine
> and would like to avoid having to download it if possible...

OK - I'll do it later (just this once :-) I don't want to as a general rule
- because I have to pay for download bandwidth -- if there's a general move
for people to want to download binaries - I'll have to beg some space on an
ftp server...

I can't just send you the binaries for the modules - because they wouldn't
load against an un-patched 2.2.17pre10.

> BTW: Note about this page: at the start there is written
> "PowerMac/Amiga/Atari/etc."
> There is no such thing as a PowerAtari... there is a PowerAmiga, yes... but no
> PowerAtari... Atari never got rid of the 68k CPU Architecture...
> (and never, never name Amiga and Atari in one sentence :) )

OK, OK, maybe I wasn't clear ==> the dmasound stuff has bits for several
machines including some of the 68k ones...

>>Having said that, I would expect your machine to work - I think it's an
>>AWACS sound chip of some variety?  If it has a DACA you'll have to wait..
>>:-(
>
> No clue what soundchip... it is a out-of-the-box "Blue/White" G3 Mac 1st
> Revision...

You can find this using "Display Name Registry" on the apple side [it's
available on the Apple web site IIRC] look under davbus:sound.

- or by looking in the /proc/device-tree on the linux side (I hope -
although, of course, this could be the root of the problem :).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
