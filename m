Date: Fri, 4 Feb 2000 21:10:20 -0500 (EST)
From: Pavel Roskin <pavel_roskin@geocities.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Non-canonical output on the serial console
Message-ID: <Pine.LNX.4.21.0002042021360.29332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm trying to run some full-screen applications (e.g. jed) on
RPX/Lite. They don't show anything, but still react on the keyboard
commands.

Also the login program from tinylogin doesn't show it's prompt.

All those programs work fine over telnet.

It appears that when c_oflag in the termios for the serial console doesn't
have the OPOST bit set, all the output gets lost.

Does anybody else have those problems?

Pavel Roskin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
