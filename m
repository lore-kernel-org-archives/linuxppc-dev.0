Date: Wed, 29 Jan 2003 12:29:11 -0700 (MST)
From: daRonin <daronin@digimerc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Radeon an 22" Apple Cinema Display
Message-ID: <Pine.LNX.4.50L0.0301291217390.1470-100000@daronin.digimerc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am trying to get Cinema Display working with my Powerbook G4 (Radeon M6
LY).

Running the latest benh kernel (2.4.20-ben4).

Tried the following video options:

video=radeon:1600x1024-8@60
video=radeon:of_edid,dfp
video=radeonfb:1600x1024-8@60

etc.

Pretty much in every of those tries the Cinema display went blank and LCD
display on the laptop went white, after the radeonfb was loaded.

The only way I can get it working is if I skip the video driver altogether
and do

video=ofonly

Unfortunately in this case I can only can 8bit colors in my X...

Any ideas how I can get his working?

Andrew


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
