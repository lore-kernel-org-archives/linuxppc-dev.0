Date: Mon, 10 May 1999 21:08:29 +0200 (CEST)
From: Gerd Knorr <kraxel@goldbach.in-berlin.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: iMac + IrDA
Message-ID: <Pine.LNX.4.05.9905102101220.9969-100000@macintoy.masq.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



  Hi !

Anyone tried to use the IrDA port of the Rev. A+B iMacs?  According to the
IrDA people I should see some packages coming in if I look at the port
while some other IrDA device tries to connect.  But I see nothing with
minicom.

The IrDA port is /dev/ttyS1, the device-tree entry looks like this:

macintoy kraxel /proc/device-tree/pci/mac-io/escc/ch-b# proc
name                      : ch-b\0
device_type               : serial\0
compatible                : chrp,es3\0
built-in                  : 
reg                       : \0\x010\0\0\0\0\x01\0\x010\x10\0\0\0\x01\0\x010@\0\0\0\x01\0\0\x86\0\0\0\x01\0\0\0\x87\0\0\0\x01\0
interrupts                : \0\0\0\x10\0\0\0\x06\0\0\0\x07
AAPL,interrupt-vectors    : \0\0\0\x17\0\0\0\x01\0\0\0\0
AAPL,interrupt-priorities : \0\0\0\x04\0\0\0\x04\0\0\0\x04
AAPL,interrupts           : \0\0\0\x15\0\0\0\x16\0\0\0\x17
interrupt-parent          : \xff\x86G\x10
slot-names                : \0\0\0\x01IrDA\0
AAPL,address              : \x80\x810\0\x80\x810\x10\x80\x810@\x80\x80\x86\0\x80\x80\x87\0
driver-ist                : \0\x05\x91\xa0\0\0\0\x0b\0\x05\x91\xa0\0\0\0\x0c\0\x05\x91\xa0\0\0\0\x0d

/dev/ttyS0 (the buildin modem) works fine with minicom.  Any hints where
to look / what to check?

  Gerd

-- 
system("logout");


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
