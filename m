Date: Fri, 22 Oct 1999 14:48:41 -0400 (EDT)
From: "Walker M. White - Math Grad" <wmwhite@math.cornell.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Changing the driver for Kensington T-Mouse
Message-ID: <Pine.LNX.3.96.991022144644.13374D-100000@main.math.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  I am not a driver hacker (All my programming experience is application
level), so I am not sure how to do this.  Hopefully someone here does, and
it willing to help me.

  The current driver for the Kensington Turbo Mouse annoys me to no end.
This is because of how it maps the buttons :
   lower left  - 1/left
   lower right - 2/middle
   upper left  - 3/right
upper right does not seem to be supported, but I have never been able to
figure out whether that is a problem with X or the driver.

  Programs in X designed with ergonomics in mind (as few as they are) use
the middle button sparingly for less routine actions;  that is because it
is more difficult to press.  Using that logic, the "middle button" for the
Turbo mouse should clearly be upper left.

  I used to be able to ignore this fact with xmodmap (Though I still did
not have a fourth mouse button).  However, Gnome overrides xmodmap and
only allows left/right-handed configuration (You can launch xmodmap AFTER 
Gnome starts, but that is also annoying). I want to stick with Gnome
because it is in sync with the Linux boxes at school.  Hence my solution:
change the kernel driver.

  So, does anyone have a clue how to do this?

-Walker


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
