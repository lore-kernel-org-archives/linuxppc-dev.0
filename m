Message-Id: <5.1.0.14.2.20020823090124.0220d5b0@falcon.si.com>
Date: Fri, 23 Aug 2002 09:10:53 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: cygwin and embedded linux
In-Reply-To: <3D64C445.836C2FC9@opensource.se>
References: <000501c24979$6348a190$37d34c93@neca.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 01:00 PM 8/22/2002 +0200, Magnus Damm wrote:

> > Are there others in this situation and how have they chosen to solve it?

[snip]

>Another way to solve it would be to switch to Linux and use VNC to
>connect
>to your Windows boxes. I'm not sure how well this works out, though.

Very well.  It comes with a Windows client that works well.  The linux
server works very well with minimal slowdown compared to a native X session
(I use Exceed for X on Windows).  If I didn't already own Exceed, I would
use VNC exclusively.  (The Windows server also works quite well, but not as
well as VNC on linux because Windows isn't really set up to do remote
windows so it has to work a lot harder and is slower as a result.)

The default window manager (TWM?) is very basic so you may want to spend
some time getting it set up better or getting a more elaborate WM running.

What is really cool about VNC is that you can start a job, reboot your
Windows box 5 times to install some trivial piece of hardware :-),
re-attach to your VNC session that was busy running your job all the while,
just in time to see your job complete.

gvb


>/ magnus

[snip]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
