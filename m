In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000204221814.20504A-100000@ofey.inetnebr.com>
Date: Sat, 5 Feb 2000 14:26:13 +0100
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: [patch] little-endian dmasound silently fails
Message-Id: <20000205142613.026592@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Feb 4, 2000, Takashi Oe <toe@unlserve.unl.edu> wrote:

>Maybe because it does support it?  Well, seriously, I've just checked the
>driver is okay wrt *S16_LE/BE at least on AWACS rev. 2.
>
>First, I wrote an app to play a sound file correctly when AFMT_S16_BE is
>specified.  Then, I modified the app so that it will byte swap the 16-bit
>data but still with AFMT_S16_BE.  As expected, it made some annoying
>noise when it was asked to play the same sound file.  Now, I modified the
>code again to let it specify AFMT_S16_LE instead.  Well, it played the
>sound file correctly just as hoped.
>
>I know a lot of people are not happy about our sound driver, but I
>don't think this is dmasound's fault.  Luckily for us, many "broken"
>OSS-compatible apps tend to work just fine if we simply modify them to ask
>for AFMT_S16_NE not *_LE, though performance critical apps should be fixed
>with more effort.

Actually, I had some reports about this problem too and I'm wondering if
all revisions of AWACS actually support byte swapping. (I think I
remember seeing a comment on this list telling explicitely that some
revisions didn't support it).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
