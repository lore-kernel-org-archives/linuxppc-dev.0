Message-ID: <381BA8A0.8F99D428@usa.net>
Date: Sat, 30 Oct 1999 22:25:37 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: More framebuffer stuff...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I found a good site for framebuffer initing (though I should have
thought of mmap() before).  However, now whenever I write to the
framebuffer, it seems to be using a color map instead of direct color
(unless I run my program under XF86).  I made sure that it is in 32 or
16 bit color, and fb_*_screeninfo even reports a packed pixel display
using direct color.  So why the colormap effect?  And why not under XF86?

-- 
--"Your mouse has been moved.  Windows 95 must be restarted for change
to take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
