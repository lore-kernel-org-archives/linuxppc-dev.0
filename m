Message-ID: <3B6385AF.1020906@hadess.net>
Date: Sun, 29 Jul 2001 04:40:31 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Paul Harrison <pfh@csse.monash.edu.au>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Turning on sound in the new iBook
References: <Pine.LNX.4.33.0107171325290.754-100000@mandarin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Paul,

Just got around trying it, and it works in the sense that "cat /vmlinux
 > /dev/dsp" produces sound ;)
The sound although contains a *lot* of noise. You're mentioning on your
page a modification to dmasound_core, could you share it with us ?

Cheers

Paul Harrison wrote:

>A few people have asked me about this, so i thought i would post it here:
>I have sound working on the new iBook, mostly from looking at the Darwin
>source.
>
>The basic steps were:
>- powering up the sound system and one of the amps by writing to some
>ports
>- setting up the digital equalizer using I2C
>- using the dmasound_pmac module for actual sound output
>
>Full details here:
>
>http://yoyo.cc.monash.edu.au/~pfh/ibook/sound.html
>
>This is all really, really hacked together. It should all probably be put
>together in one or two nice neat kernel modules at some stage.
>
>--
>Paul Harrison
>
>Email: pfh@csse.monash.edu.au
>Web:   http://yoyo.cc.monash.edu.au/~pfh/
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
