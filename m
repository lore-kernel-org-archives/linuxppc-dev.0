Date: Sat, 19 Jun 1999 23:37:05 -0500 (CDT)
From: Kevin Heflin <kheflin@shreve.net>
To: linuxppc-dev@lists.linuxppc.org
cc: linuxppc-dev-digest@lists.linuxppc.org
Subject: Ethernet troubles and R5
In-Reply-To: <199906190459.XAA32534@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.9906192326580.2461-100000@mercury.shreve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry to post to this list, because I'm certainly not a developer. But was
hoping to get some suggestions on the following trouble.

I've just recently installed the new R5 release from the shipped CD
version. My internet connection is via an ISDN router. All I've ever had
to do with LinuxppcR4 was plug in basic network info like IP address,
Gateway address, subnet mask and DNS numbers. My file transfers for ftp
and http always seemed faster when compared to the MacOS.

However, since installing R5, it does not matter from where I ftp or view
web pages from, my transfers never get above 1.5 kB/s
I have another macintosh on my same network, running macos. I can try
downloading files from any of the same locations, and I can get anywhere
from 10 kB/s to 15 kB/s 
I'm certain this is not an isolated incident or the ftp sites I'm hitting
are slow. I just never see transfers above 1.45 kB/s

Things like telneting to other machines on the net.. seem very responsive,
and if I try pinging other locations they are the same as I've usually
seen. It's just sustained transfers never get above the magic number of
1.5 kB/s

I've tried posting this question to the linuxppc users list, but got no
response. I'm wondering if this has anything to do with the fact that I'm
running a UMAXS900 with whatever ethernet card it has, instead of the
standard Apple hardware and ethernet?

I didn't know if there were any other kernels I can try? Any suggestions
would be appreciated.

Kevin


--------------------------------------------------------------------
Kevin Heflin          | ShreveNet, Inc.      | Ph:318.222.2638 x103
VP/Mac Tech           | 333 Texas St #175    | FAX:318.221.6612
kheflin@shreve.net    | Shreveport, LA 71101 | http://www.shreve.net
--------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
