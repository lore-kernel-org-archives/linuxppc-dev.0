Message-ID: <37406460.9B171AC8@pop.agri.ch>
Date: Mon, 17 May 1999 20:48:00 +0200
From: Andreas <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Dev-LinuxPPC <linuxppc-dev@lists.linuxppc.org>
Subject: atyfb and Powerbook G3 250 (wallstreet)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

last week I got my Wallstreet G3 250 back from repair. They changed
CPU-Board, Chache, Flex Cable and the Display. Don't know why. On the
MacOS all works ok so far.
Then I tried LinuxPPC kernel 2.2.6 with no video driver off -> should
use atyfb.
I worked for half an hour on the text mode trying to build one of the
latest kernel. After this half hour the screen went into unreadable
chars. As usual I thought nothing bad and did a reboot. Same situation
even worse. Changed back to kernel 2.2.4, same behaviour. Then I checked
the option no video driver. Huh, the book came in readable chars up. At
least the console modus works. I then shutdown because I'm very unsure now.

I was working with PB and Linux for quite a long time with different
kernels. Since BootX gives the option to enter kernel options I did. I
set video=atyfb vmode:14,cmode:32 and mclk=63.

Now I don't know if I hurt the book with this Linux or do I have a ***
book which  is very affective on things like that.

Does anybody had symptoms like that? Do I have set something wrong?

Any hints are appreciated,

thanks
Andreas

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
