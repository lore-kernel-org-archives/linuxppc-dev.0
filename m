From: bob@kunk.jriver.com
Message-ID: <19990724054437.8.qmail@kunk.jriver.com>
Subject: 2.2.10 compile and usb kbd on iMac
To: linuxppc-dev@linuxppc.org
Date: Sat, 24 Jul 1999 00:40:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm trying to get to the point of being able to work on usb printers but
have run into a problem.

I'm compiling the 2.2.10 kernel from sources 
ftp://sunsite.anu.edu.au/pub/linux/linux-pmac/kernel-source/v2.2.10

I can get it to compile OK, using the dot.config from the binary dir.

The problem is that it doesn't matter whether I use my compile or the
binary from the ftp site, I can't get the iMac usb keyboard to work, the
keys are in the "wrong" place. Even in just text mode, the keys are
generated but they are wrong. I found the usb.map file in the source
tree but I'm not sure where to put it. I can't find this documented, can
anyone help? Should the usb.map file fix the problem?

Thanks,
Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
