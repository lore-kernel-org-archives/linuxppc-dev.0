Message-ID: <369686E0.903B673D@bigpond.com>
Date: Sat, 09 Jan 1999 09:29:59 +1100
From: Tom Kennedy <tomkenn@bigpond.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.0pre5 controlfb problems
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since 2.2.0 pre series the console on my 8500 has been causing
problems.

1.  Scrolling is very slow, and is jerky
2. The left margin reset itself 10-15 characters to the right and the
cursor
     scrolls off the bottom of the screen.
3. Swapping virtual consoles will reset the screen back to normal.

Under pre4 and earlier I was experiencing machine hangs. This is
probably unrelated
to controlfb. Has not happened to date in pre5.


tom kennedy


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
