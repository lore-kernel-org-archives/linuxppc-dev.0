Date: Fri, 28 May 1999 18:11:31 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Hollis R Blanchard <hollis+@andrew.cmu.edu>
cc: Dan Malek <dmalek@jlc.net>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sound stuff (was Re: G3 sound recording)
In-Reply-To: <Pine.LNX.3.96L.990528094356.1314B-100000@unix47.andrew.cmu.edu>
Message-ID: <Pine.LNX.4.05.9905281810100.794-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 28 May 1999, Hollis R Blanchard wrote:

> Second, this reminded me of two sound things, both about the CD player. 1) If
> I'm playing an mp3, any sox output (like Licq's notifications) gets played
> after the mp3 has finished. Kinda like Windows, except the sound does
> eventually play instead of getting dropped. But, if I'm playing a CD, I can
> hear ICQ messages fine, simultaneously (more like the Mac OS). I assume this

This can be fixed in part by esound and esound compliant apps.  Ie: stick
x11amp into esd mode, and find an icq client that can send its sounds to
esd.  Then you'll here 'em like in MacOS.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
