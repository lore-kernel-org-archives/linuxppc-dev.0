Message-ID: <37FAB661.CB729B2D@usa.net>
Date: Tue, 05 Oct 1999 22:39:30 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: controlfb working at 1024x768@60 Hz
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After several inquiries without answer, I decided to find out for myself
why controlfb always reverted to vmode 17 when I set it to 14 (even with
fbset).  Apparently, whenever the geometry is set to 1024x768, the
refresh rate is automatically set to 75 Hz.  I set the default value to
60 Hz instead, and now it works fine with my monitor (which doesn't do
75 Hz).  If anyone has a similar problem, there's your fix.  However,
controlfb still doesn't do kernel args (for what reason I can't fathom),
and having a default value for every resolution is not the right way to
go.  I, however, have no idea how to implement a more permanent solution
(i.e., it actually goes to vmode 14 when you set it there, and vmode 17
when you set it there).

Anyway, I'd include a patch for this if I knew how to use diff, but I
suppose you'll just have to find the spot yourself if you need to fix it.

Hope this helped,
	David


-- 
--"Your mouse has been moved.  Windows 95 must be restarted for change
to take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
