Message-ID: <37F7AC60.4F6BEA3B@usa.net>
Date: Sun, 03 Oct 1999 15:19:59 -0400
From: David Riley <happyoscar42@usa.net>
Reply-To: happyoscar42@usa.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: using ld properly
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How do I use ld properly (with a Makefile)?  I tried "ld -o heyworld
main.o func.o /usr/lib/crt1.o -lc", but it gives me the output file
heyworld, and when I try to do ./heyworld, it says bash:./heyworld:bad
command or filename (or whatever it says).  it works fine if I do "gcc
-o heyworld *.o" to link it, but I want to be able to link using ld
(just to do iot, you know).  I know gcc calls ld by itself (or does
something similar), but doing gcc -verbose did nothing useful for me.

Thanks,
	David

-- 
--"Your mouse has been moved.  Windows 95 must be restarted for change
to take effect."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
