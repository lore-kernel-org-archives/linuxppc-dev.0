Date: Fri, 4 Feb 2000 17:59:13 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Brad Midgley <brad@turbolinux.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
In-Reply-To: <Pine.LNX.4.20.0002041513270.27409-100000@mail.turbolinux.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000204175200.3438D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Feb 2000, Brad Midgley wrote:

> ha. that's a pun. it's not silent at all when you listen.
>
> seriously, the dmasound driver advertises itself as little-endian capable
> but doesn't provide the proper translators. so clients like openh323
> switch the mode to little-endian (without any errors) and write
> little-endian data and the result is a hissing noise!

How does it write "little-endian data"?  Does the program take care of CPU
being big-endian in some way?  If not, I'd think it's the program's fault.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
