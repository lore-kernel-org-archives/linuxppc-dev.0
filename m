Subject: Re: Sound on G4 tower, success
From: James Baughman <jbaughmn@arlut.utexas.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20011026120847.6797@smtp.adsl.oleane.com>
References: <85r8rtcnzj.fsf@junk.nocrew.org>
	<20011026120847.6797@smtp.adsl.oleane.com>
Content-Type: text/plain
Date: 26 Oct 2001 22:08:31 -0500
Message-Id: <1004152111.1119.62.camel@ti>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Can you tell me if the version of dmasound in my current rsync
> helps getting sound our of speaker ? It should mute the speaker
> when the jack is plugged and unmute it when unplugged. Can you
> verify this behaviour ?

The speaker is working on my dual 800/G4 from the kernel in your tree of
10pm Thurs. night.  Thanks!  I've not tried to plug anything into the
jack yet though.

Also, it seems as though the mixer isn't working quite right.  The
actual  volume (using aumix or xmixer) doesn't seem to correspond to the
level indicated on the mixer GUI.  If I set the volume to its lowest
setting, the actual volume could be cranked.  As I increment the volume
slider, the volume seems to randomly get louder and softer all the way
up to the slider's maximum.

--
Jim Baughman
Applied Research Laboratory
University of Texas, Austin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
