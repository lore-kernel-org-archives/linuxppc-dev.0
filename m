Message-ID: <381B4E5E.5270E3B@usa.net>
Date: Sat, 30 Oct 1999 16:00:30 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Framebuffer writes
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I suppose this is a silly question to the initiated, but how do I write
to the framebuffer?  I can get the address fine, but I've never
programmed in a protected memory environment (I program in MacOS, where
applications are free to overwrite the system heap ;-), so when I try to
do a write of any kind (*(startAddr + offset) = color) it segfaults. 
What is the routine to write like this?
-- 
--"Your mouse has been moved.  Windows 95 must be restarted for change
to take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
