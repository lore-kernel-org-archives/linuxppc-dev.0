Message-ID: <379D203D.FAAA971@jriver.com>
Date: Mon, 26 Jul 1999 21:58:05 -0500
From: Robert Brose <bob@jriver.com>
Reply-To: bob@jriver.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: usb mouse in 2.2.10
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for those that helped with the usb keyboard and 2.2.10. Now that the
keyboard is working
on the iMac, I've got one observation and a question.

1) The keyboard response is somewhat odd. If I type "cd /anything" at the
prompt, it fairly
regularly does cdcd /anything on the echo. It's hard to pin down because it
isn't
completely consistent. I'm guessing an odd debounce problem.. It seems to only
happen on
a few characters. The same machine works fine with 2.2.5.

2) The mouse is inoperative in X. The links are...
[bob@imac /dev]$ ls -l *mouse*
crw-r--r--   1 root     root      10,  10 Apr 30 10:54 adbmouse
lrwxrwxrwx   1 root     root            8 Jun 16 12:08 mouse -> usbmouse
crw-rw-r--   1 root     root      10,   6 May  5  1998 sunmouse
lrwxrwxrwx   1 root     root           11 Jun 16 11:45 usbmouse -> hidbp-mse-0

The X pointer section..
Section "Pointer"
    Protocol    "BusMouse"
    Device      "/dev/mouse"

If I cat /dev/mouse and move it I get moving lines of junk as I would expect.
The bus mouse
protocol looks suspicious but it works in 2.2.5 and I haven't found anything to
replace it with
yet.

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
