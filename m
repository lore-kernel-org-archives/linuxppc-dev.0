Message-Id: <200002141749.LAA26552@lists.linuxppc.org>
Date: Mon, 14 Feb 2000 12:45:53 -0500 (EST)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: Bug in acceled Xpmac?
To: linuxppc-dev@lists.linuxppc.org, ningerso@d.umn.edu
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Yes, thjere was a serious mouse bug problem with usb mice fixed in
Xpmac rev8 and later versions.  It seems that the accelerated Xpmac
was not properly setting an accurate time for the mouse button
events.

Please try upgrading to Xpmac rev9 and try again (see
http://www.linuxppc.org/BlueG3/ for a link.

If you still have a mouse problem with Xpmac rev9, please let me
know.

Thanks,

Kevin

>It looks like the accelerated Xpmac that was released in January
may have
>a bug in mouse handling.
>
>I was working on a small epplet for one button mouse users to make
better
>use of enlightenment. When using the version of Xpmac that shipped
with
>LinuxPPC 1999 Q1 it worked fine. But when using the recent
accelerated
>version, the mouse functionality wouldn't change.
>
>XGetPointerMapping returns the values that were set, but it doesn't
seem
>to be updating the way it handles the button.
>
>Has anyone else seen similar behavior or know of a fix? I attached
the
>source of my program for anyone interested in trying it out.
>
>-------------------------------------------------------------------
--------
>|   Nathan Ingersoll             |   Computer Science/Mathematics
      |
>|   mailto: ningerso@d.umn.edu   |   University of Minnesota-Duluth
      |
>|   http://umn.edu/~ningerso     |   http://www.d.umn.edu
      |
>-------------------------------------------------------------------
--------
>

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
