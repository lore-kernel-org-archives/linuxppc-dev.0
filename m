Subject: airport transmit power
From: Ryan Boder <boder@cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Date: 19 Mar 2002 01:39:53 -0500
Message-Id: <1016519993.843.21.camel@TOBY>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm using airport in a big 802.11b network at school, with access points
all around campus. I have noticed that networking does not work as well
for me as it does for those using intel machines.

But the thing I just noticed tonight, is that my machine seems to
receive signals just as well as the intel machines, it's the
transmissions that cause trouble.

For example, I was downloading a 700 MB files and it kept downloading
withought a problem, but at the same time, I was trying to work on a
remote machine with ssh and it was acting really bad. Sometimes it would
not respond to my keyboard pressing for 30 seconds or more.

I also noticed that this is the only available txpower from iwlist.

eth1      1 available transmit-powers :
	  15 dBm  	(31 mW)

So for anyone who hacks the aiport driver, is that the only txpower the
card supports? Is it a hardware limitation or a driver limitation? Or is
it something that's unknown since apple won't release the documentation?

Ryan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
