Date: Mon, 9 Aug 1999 14:28:57 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: SOCKS5 (fwd)
Message-ID: <Pine.BSI.3.96.990809142731.8362A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I sent this over the weekend, but I didn't see it come through so I'm
wondering if it got lost somewhere.  I'm still getting messages for the
list, and its in the archives, but several of the archived messages I never
got, so just in case.... I'm sorry if you've gotten it before.

---------- Forwarded message ----------
Date: Fri, 6 Aug 1999 20:29:00 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: SOCKS5

Has anyone gotten socks5 compiled and working under LinuxPPC?  I'm going
through the instructions at:

http://www.sfu.ca/~yzhang/linux/socks5/index.html

And can build it fine, but the test he says to run before really doing
anything gives a segmentation fault when using some variable args stuff.

A function is called that accepts a variable parameter list, and it causes a
seg fault.  Are there any weirdnesses in R5 on the PowerPC with the varargs
stuff that can get by on other platforms?  Or does anyone have patches to
get it to work?  Or is there an alternate proxy server that I've somehow
missed that will work?

Thanks.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
