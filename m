Message-ID: <36C33FEB.FDB02302@babcockbrown.com>
Date: Thu, 11 Feb 1999 12:39:07 -0800
From: root <hughc@babcockbrown.com>
MIME-Version: 1.0
To: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: R5 Install (Mostly) Successful on PBG3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am able to install pre-R5 on my G3 Series laptop again, using the
latest RPMS from mirror.  I used Martin Costabel's "big" ramdisk image
and a 2.1.125 kernel.

There were a few failures during intstall.  The main problem I have is
that RPM doesn't work; any attempt to use it returns an error
"//var/lib/rpm/nameindex.rpm: Invalid argument"

Is it the double slash at the beginning of that line?  Where is it
getting that path?  Using --dbpath doesn't seem to help...

Hugh

--
Hugh Caley, System Administrator
Babcock & Brown, Inc., San Francisco
1+512+1515x694 | hughc@babcockbrown.com




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
