From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Kostas Gewrgiou <gewrgiou@imbc.gr>
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Thu, 24 Feb 2000 13:53:39 -0500
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr>
In-Reply-To: <Pine.LNX.4.21.0002241917120.2343-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Message-Id: <00022413570000.00452@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kostas,

I previously I had updated only the Xfree86 and r128 drivers (I had been using
them installed over XFree 3.3.6) and it worked perfectly.  To see if the issue
with select vs poll and Netscape had been resolved I installed the full xf
3.9.18.

Although my X started up fine, the mouse was completely messed up (it thought
buttons were being pressed, etc).  This is with a usb mouse on B+W G3.

I looked at the xfree86 change log and noticed that there were alot of recent
changes to the mouse drivers (especially for ps2 and usb).

Have you synced your xf 3.9.18 since about Feb 17th or so (the date of the
last mouse change) and if so, have you had any problems with mouse drivers
using usb mice?

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
