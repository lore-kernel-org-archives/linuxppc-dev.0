From: "Brian Padalino" <bpadalino@perigee.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: PPCBoot on Ebony board
Date: Tue, 15 Jul 2003 14:11:07 -0400
Message-ID: <DGEEIPOFGGPOACEFBGGCOEGPCAAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <5.1.0.14.2.20030715092123.02ef0d20@mail.ebshome.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am trying to transfer PPCBoot that I had compiled over a tftp session in
the 440GP 1.18 ROM Monitor (02/11/02) that came on the Ebony board.  Is that
the wrong method of trying it?  I tried using both serial ports and Kermit
with Xon/Xoff handshaking, but it just ended up timing out.

I keep getting the error:
  Loading file "C:\ppc\bootp\boot.img" ...
  Sending tftp boot request ...
  Not a valid boot image file

Which stems from an improper magic number at the top of the file to say it's
a valid boot image.

I hate to sound like such a newbie, but can anyone help in getting PPCBoot
on this new board?  Any help would be very appreciated.

Thank you,
Brian Padalino


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
