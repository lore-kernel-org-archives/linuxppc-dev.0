Date: Fri, 28 May 1999 09:51:44 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Sound stuff (was Re: G3 sound recording)
In-Reply-To: <374E372F.25549C60@jlc.net>
Message-ID: <Pine.LNX.3.96L.990528094356.1314B-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 May 1999, Dan Malek wrote:
> 
> To the mixer read/write recording source I added the SOUND_MASK_MONITOR
> because the AWACS has the "loop through" capability.  When this is
> set, along with your recording input selection, the audio input
> will be sent to your selected audio output (along with giving you
> the data).  This is the way the audio CD players work, so if you
> turn this off don't be surprised when an audio CD program may not
> play.  If this was not the right mask to use for this purpose, will
> someone with more knowledge please tell me what is correct.

First, that's awesome Dan. =)

Second, this reminded me of two sound things, both about the CD player. 1) If
I'm playing an mp3, any sox output (like Licq's notifications) gets played
after the mp3 has finished. Kinda like Windows, except the sound does
eventually play instead of getting dropped. But, if I'm playing a CD, I can
hear ICQ messages fine, simultaneously (more like the Mac OS). I assume this
is because the kernel would have to mix the sounds itself in the first case,
and the sound chip does it in the second? I guess this is a Linux limitation,
but does any kernel hacker have a quick hack so sounds get dropped instead of
queued? I don't really like getting 10 "uh-oh"'s when a song finishes because
I've been having a conversation.

The other thing was, does anyone remember the CD audio volume level being
adjustable before? I've been using 2.2.x for a while, and all I get is the
left channel either on or off. I could have sworn I used to be able to
actually adjust both channels's volumes to whatever I wanted (maybe in
2.1.x?). Am I remembering this wrong?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
