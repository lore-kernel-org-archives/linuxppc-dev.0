Message-ID: <37C717B2.74C7E009@x8.net>
Date: Sat, 28 Aug 1999 00:56:50 +0200
From: Wolfgang Haeuptli <haeuptli@x8.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: serial port with 31250B ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello everybody

How can I set the serial communications rate to 31250 b ?
stty only accepts the baud rates defined in asm/termio.h (19200 or 38400
etc.).
If there's no utility for this purpose, could anybody give me a hint how
to do this (driver for asynchronous comm. with arbitrary baud rates
...?)

The reason for this question: the midi protocol uses this rate. With it,
linuxppc could probably finally use music software based on midi.

Thanks

Wolfgang

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
