Date: Mon, 26 Apr 1999 09:42:42 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Pty problem in RawHide
Message-ID: <Pine.LNX.3.96.990426091814.16776A-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I can't telnet into my SuperMac S900, newly installed with RawHide 1.3.4
from ftp.linuxppc.org on Friday April 23rd. At first all connections where
simply refused (telnet, finger, etc), but I traced this down to inetd.conf
having ALL services commented out by default (why?) Anyway now I get
"telnetd: All network ports in use"! Even when telneting to 127.0.0.1 from
the console. Also attempts to run xterm fail with "xterm: no available
ptys"! 
 
Am I missing another configuration file somewhere? I've checked /dev and
there are plenty of ptyXYs in there. I've built my own telnetd from the
src.rpm and it seems that openpty() always returns -1. Anyone else having
this problem? I really don't want to start hacking glibc to see what is
going on. 

Until this week, I had been using an earlier RawHide from ftp.linuxppc.org
and telnetting was a non-issue (as it should be :-)) 

Kevin Hendrickson

*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
