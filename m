Date: Tue, 23 May 2000 17:31:54 -0700 (PDT)
From: Wilhelm Fitzpatrick <rafial@well.com>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Sergio Brandano <sb@dcs.qmw.ac.uk>, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org, stephan@jvc.nl
Subject: Re: Debian pmud package available 
In-Reply-To: <Pine.LNX.4.10.10005231934210.4083-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.GSO.4.10.10005231723200.1902-100000@well.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> OK, the Debian package plus diff/changes/dsc stuff is up for testing on
> ftp.biophys.uni-duesseldorf.de:/pub/linux/powerpc - it's not a final
> version yet, I need to figure out how to have the Debian postinst
> automatically create the /etc/rc*.d symlinks. If someone wants to play
> with it, go ahead.

I'm testing, seems good on my PB3400.  It's nice being able to have the
network interface cycled automatically, and I added "trackpad notap" to my
wakeup sequence so I don't forget ;)

A few questions --

what is xmouse?  Why is it included?

Also, the gnome battery monitor applet tells me I don't have APM support.
Batmon is okay, but I'd really like to have panel applet battery level.
Is this just not supported yet?

-raf


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
