Message-ID: <39FB3C16.3359BC41@the-rileys.net>
Date: Sat, 28 Oct 2000 16:50:38 -0400
From: David Riley <oscar@the-rileys.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: PPC byte ordering
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Before I get dirty looks, I know the PowerPC's default byte ordering is
big-endian (the way things *should* be :-).  What I'm asking is slightly
irrelevant to most development discussion here, but...

I know that the PowerPC does allow both endian modes.  My big question
is how well it works in little endian mode.  I know we'll never switch
Linux to this, since that would be too much unnecessary work, but just
for reference:  Is it broken?  I have heard reports to this effect.

Thanks,
	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
