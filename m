Date: Wed, 18 Jul 2001 13:00:00 -0500
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: iain@sandoe.co.uk, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
Message-Id: <20010718130000.7cc04c7a.jpgarcia@execpc.com>
In-Reply-To: <3B5586AB.7000604@hadess.net>
References: <20010718111339.6EF762EFBD@apollo.valhalla.net>
	<3B5586AB.7000604@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 18 Jul 2001 13:52:59 +0100
Bastien Nocera <hadess@hadess.net> wrote:
> Why would pmud make sense for the backlight ? because changing the
> backlight settings saves power ? ..Right.

I suppose if we wanted a userspace interface to the backlight, would ioctls on the /dev/fb# be an adequate solution.  Since the display probably doesn't have any more direct path than through the video driver its connected to.  Newworld seem to have the backlight control there anyway.  I'm not sure where I stand on this one.  The question - are the brightness buttons considered an extention of the monitor, or owned by the keyboard.  If it's the former, it sounds like as it is is best (kernelspace).  If its the latter, the keys are just keys, and thus a userspace solution to connect the keys to the [ioctls] would be proper.

I lean toward kernelspace myself, ie. the buttons are owned by the screen.  Basically, I'd expect there to be two sets of brightness buttons had I two LCDs.  Eject keys feel the same way, so I'd think kernel level is more proper.  But am I talking pcmcia eject keys or cdrom eject keys...  ouch.  How does MacOS arbitrate the keyboard's eject key to one's cdrom or zip?  Is it just like command-E?  (I'm oldworld.)

The fact these hardware quirks are showing up more and more in new desktops (Mac and PC) means some standard methods might need to be established..  one thing I hoped I never would need is a 'pmac-kbd' daemon... but...

--
Joseph P. Garcia
http://www.execpc.com/~jpgarcia

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
