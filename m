Date: Tue, 12 Feb 2002 14:15:00 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: SUNGEM config
Message-ID: <Pine.LNX.4.33.0202121351140.23572-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Ben,

 A while back when the question was asked as to why we should use SUNGEM
instead of BMAC or GMAC, you said something to the affect that it offers
config options. I read through the pdf from the kernel config help and it
mentions a ge.conf file. So, if I got this right, I simply create an
/etc/ge.conf file and this will allow me to force XBaseT and Auto or
forced full/half duplex?

 I've been trying it with my iBook2 and 2.4.18pre8 and so far it works
very well. However, when my iBook is not connected, it keeps on try to
negotiate an eth0 connection (/var/log/messages):

Feb  7 15:42:53 shiva kernel: eth0: switching to forced 10bt
Feb  7 15:43:14 shiva kernel: eth0: switching to forced 100bt
Feb  7 15:43:21 shiva kernel: eth0: switching to forced 10bt
Feb  7 15:43:41 shiva kernel: eth0: switching to forced 100bt

So, it would be nice to turn this off other than turning off
/etc/rc.d/init.d/network.

 Is there a place where I can find docs for this? I tried google searches
for ge.conf linux with not much luck.

 Any enlightenment short of a LART would be much appreciated. :-)

Cheers,

Chris

--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
