Date: Sun, 7 Feb 1999 10:01:45 -0500
Message-Id: <199902071501.KAA01352@wogglebug.cygnus.com>
From: Michael Meissner <meissner@cygnus.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Booting a PowerStack-II on a serial line
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is there any way I can tell at the shell level whether or not the
PowerStack-II machine was booted via a serial line or with a
monitor/keyboard?  I normally boot the machine via the serial line,
and discovered that the gettys for the virtual console were respawning
without end.  I edited the inittab to remove them, and put a normal
login at 9600 baud on /dev/ttyS0 on runlevel 3, but was wondering if
there was a way to switch automatically.

Also, I found I can't compile with the console on a serial line and
mac serial option (ie, can't use the common pmac/prep/mxb mode, I had
to use the prep/mxb mode) due to both trying to define the same
function.

-- 
Michael Meissner, Cygnus Solutions (Massachusetts office)
4th floor, 955 Massachusetts Avenue, Cambridge, MA 02139, USA
meissner@cygnus.com,	617-354-5416 (office),	617-354-7161 (fax)

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
