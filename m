Message-ID: <19990816163922.1666.rocketmail@web116.yahoomail.com>
Date: Mon, 16 Aug 1999 09:39:22 -0700 (PDT)
From: David Hay <hay_dave@yahoo.com>
Reply-To: hay@colorado.edu
Subject: USB: Device or resource busy?
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been trying to get my USB card and mouse working but no such luck.  I've
tried compiling the latest 2.2.10 kernel from cvs.on.openprojects.org with
USB modules turned on, so I now have a usb-ohci and mouse module.  However,
if I try to load the usb-ohci module via modprobe and I get a message in
/var/log/messages indicating that it's trying to load USB driver, but then I
get an error back like (this is from memory):

init_module: Device or resource busy

What does this mean?  More specifically, how do I get my USB mouse to work?
(I have a Kensington mouse-in-a-box scroll mouse).  Thanks!

David

===
------------------------------------------------------------
 David Hay                                     \|/ ____ \|/
 hay@colorado.edu                              ~@-/ oO \-@~
 http://home.earthlink.net/~dhay/              /_( \__/ )_\
 ~ Live well ~ Laugh often ~ Love much ~          \__U_/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
