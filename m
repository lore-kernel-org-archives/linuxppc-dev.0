Date: Wed, 21 Nov 2001 16:36:13 +1100
From: Anton Blanchard <anton@samba.org>
To: Bill Fink <billfink@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
Message-ID: <20011121163613.D10454@krispykreme>
References: <20011119111548.F4531@krispykreme> <Pine.LNX.4.33.0111202216050.17140-100000@gwiz.nasa.atd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111202216050.17140-100000@gwiz.nasa.atd.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> That's an understatement.  That's damn good!  I hope I can reproduce
> that.  What NIC card were you using?  Unfortunately, I just checked
> the NetGear web page and they don't seem to have the GA620T anymore.
> They now have a GA622T, but I believe that uses a different chip,
> which I don't think is supported by the acenic driver.

Yes I use acenic type cards (IBM and Netgear GA620). I havent tested
the GA622 at all although I think there is a Linux driver for it.

> Is there any more extensive documentation anywhere for
> how this auto tuning of TCP receive and send buffers is done?

Check out Documentation/networking/ip-sysctl.txt in the kernel source
for some information. Its not much but its a start :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
