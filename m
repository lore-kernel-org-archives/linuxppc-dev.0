Date: Fri, 16 Jul 1999 10:49:36 +1000
Message-Id: <199907160049.KAA23985@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: jquinn@nortelnetworks.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <14222.9603.505701.976724@gargle.gargle.HOWL>
	(jquinn@nortelnetworks.com)
Subject: Re: Broken sound?
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <14222.9603.505701.976724@gargle.gargle.HOWL>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Jerry Quinn <jquinn@nortelnetworks.com> wrote:

> I have a Powercenter 120 with 200Mhz 604e card running vanilla 2.2.10.  Sound
> seems to be broken.  I do 'cat junk.au > /dev/audio' and get very interesting
> sounding static.  Is there a patch in vger I should be using that hasn't made

What is the nature of junk.au?  Is it 16-bit or 8-bit, stereo or mono,
linear, mu-law or A-law encoded, and if it's 16-bit, is it big-endian
or little-endian?

When you open /dev/audio, the driver sets it to 8kHz, mono, mu-law
encoded.  It's possible that the mu-law decoding is stuffed, I've
never used it myself.  I just tried catting a .au file to /dev/audio
and it worked fine, though.

> Also, if I send a sound to /dev/audio, it plays through both internal and
> external speakers.  If I try to send the sound to /dev/audio1, bash claims it
> doesn't exist even though it shows up on 'ls'.

You can use one of the many mixer programs to set the volume levels
for the internal speaker and the headphone output.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
