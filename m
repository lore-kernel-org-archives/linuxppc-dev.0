Date: Tue, 17 Jul 2001 15:29:39 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: benh@kernel.crashing.org, Franz.Sirl-kernel@lauterbach.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
Message-Id: <20010717152939.5c01fd5f.jpgarcia@execpc.com>
In-Reply-To: <Pine.LNX.4.33.0107171622010.27602-100000@opal.biophys.uni-duesseldorf.de>
References: <20010717101901.21603@smtp.adsl.oleane.com>
	<Pine.LNX.4.33.0107171622010.27602-100000@opal.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 17 Jul 2001 16:40:24 +0200 (CEST)
Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
> Why pmud? For backlight I kind of see how you'd get that notion. But
> volume?
...
> handle all this. That way, users could even customize the thing to get
> particular functions mapped to keys :-)

I agree.  At least at the moment, there are measures to have volume controls in the new input layer.  Else, why would there be macros in input.h for them.  Assuming that this is generally preferred direction, it would require a shell- or X-based handler.  I'm sure that if keycodes are set up properly, you could have Sawfish or Enlightenment capture the key stroke and use it like macos with the volume bar appear at the bottom (if you want that sort of thing).  In console, it would be different.  But taken as stated, this starts to put bloat wherever it goes.  Having a window manager call aumix isn't very linux like, but I'd argue that its the kind of result you would get in a nice integrated environment like kde or gnome would like to attain.  if the user doesn't realize its part of the wm, and the code is clean, it should be tolerable.

So the question is, should I pursue a NIL approach and maybe others with similar keys will follow, or come up with another api using events (and basically deprecate three of many of the unused NIL keys for our own purpose).  I'd prefer following the NIL approach, but coming up with a good method to handle these without bloating, say,  bash and sawfish at the same time.

Suggestions on non-cascading methods of NIL support?  are mingetty and X the best places to aim for without changing everything, or is there better?  are these even supposed to know what the NIL is?  Or is a daemon really the way to go?

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
