Date: Thu, 4 Feb 1999 09:58:51 -0700 (MST)
From: Jeff Rugen <jrugen@primenet.com>
To: Linux Framebuffer List <linux-fbdev@vuser.vu.union.edu>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: PReP framebuffer patches (clgenfb)
Message-ID: <Pine.BSI.3.96.990204095207.8577A-100000@usr08.primenet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have some pacthes to get clgenfb working on the Motorola Powerstack
available (finally :-)  )  They are against 2.2.1, since I haven't been able
to get a vger kernel running (haven't looked into it much -- happens
immediately after decompressing the kernel though).  I'd appreciate any
feedback.

The page is:  http://www.primenet.com/~jrugen/linux/linuxppc.html

I also have a version of Xbh on the page (compiled against pre-R5 XFree86
libraries) that has some support for 16- and 32- bit color (it comes up in
both modes, and 32-bit color seems to work fine except for lots of flicker
when text scrolls.  16-bit color comes up with the right colors, but xv on a
jpeg shows a definite lack of green...

I have more text about each bit on the page itself.

----------------------------------------------------------------------------
Jeff Rugen                      jrugen@primenet.com

...Had this been an actual emergency, we would have fled in terror, and you 
would not have been informed.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
