In-Reply-To: <389D018F.A081DBFF@unlserve.unl.edu>
Date: Sun, 6 Feb 2000 14:34:24 +0100
To: Takashi Oe <toe@unlserve.unl.edu>, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: [patch] little-endian dmasound silently fails
Message-Id: <20000206143424.013230@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 5, 2000, Takashi Oe <toe@unlserve.unl.edu> wrote:

>Do you have any idea if they are used with G3 PowerBooks under Mac OS?
>There was a report long time that an user would lose ability to play
>audio CD from media bay drive after sleep, and he needed to boot Mac OS
>completely before coming back to Linux to get the lost audio CD
>capability back, though beep and other sound functions weren't affected
>at all.

They don't seem to be called on the wallstreet. In recent kernels, me and
Paul added a few timing fixes (mostly some delays here or there) and I
added some basic power control via the FCR register. I now have sleep
working fine when getting out of sleep. I can even play an MP3, sleep,
and the play resumes when I wake up.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
