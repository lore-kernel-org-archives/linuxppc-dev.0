From: Steffen Haeuser <SteffenH@hyperion-software.de>
Reply-To: SteffenH@hyperion-software.de
To: Iain Sandoe <iain@sandoe.co.uk>, daenzerm@student.ethz.ch,
        linuxppc-dev@lists.linuxppc.org
Date: Tue, 25 Jul 2000 17:50:21 -0500
Message-ID: <yam8241.1084.150101632@mail.lf-online.de>
In-Reply-To: <200007251441.PAA21903@hyperion.valhalla.net>
Subject: Re: sound again [was: Re: xf4 bug report]
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am 25-Jul-00 schrieb Iain Sandoe:

Hi!

>OK, which was the last working version (prob. easiest is if you mail me
>drivers/sound/dmasound.c).  I can diff that to what we have under 17preXX
>and see if there are any clues...

Hmmm, I never touched the source code... the latest with working sound was
2.2.15
... well, actually I never tried the sound there... but I *think* this error
message
during bootup concerning sound came first with the new kernel (something about
dma
it said... if that helps I can look up the exact error message...).

>I did a back-port of the 2.4.0-test4 dmasound stuff to 2.2.17pre10-ben2
>(will check on pre13-ben1 later):
>http://www.drfruitcake.com/linux/linuxppc.html

I guess the dmasnd-v2a.patch is the file to get ? Hmmm, is there also a Binary
Version available somewhere ? I do not have the latest Kernel Source on my
machine
and would like to avoid having to download it if possible...

BTW: Note about this page: at the start there is written
"PowerMac/Amiga/Atari/etc."
There is no such thing as a PowerAtari... there is a PowerAmiga, yes... but no
PowerAtari... Atari never got rid of the 68k CPU Architecture...
(and never, never name Amiga and Atari in one sentence :) )

>Having said that, I would expect your machine to work - I think it's an
>AWACS sound chip of some variety?  If it has a DACA you'll have to wait..
>:-(

No clue what soundchip... it is a out-of-the-box "Blue/White" G3 Mac 1st
Revision...
no changes...

Steffen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
