Date: Fri, 3 Mar 2000 22:35:08 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: Gabriel Ricard <g_ricard@yahoo.com>, linuxppc-dev@lists.linuxppc.org,
        linux-usb@suse.com
Subject: Re: [linux-usb] Re: USB Device Driver Development Resources
Message-ID: <20000303223508.A19293@suse.cz>
References: <20000303180757.9695.qmail@web1704.mail.yahoo.com> <200003032108.QAA25344@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003032108.QAA25344@p2.parker.boston.ma.us>; from Brad Parker on Fri, Mar 03, 2000 at 04:08:39PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 03, 2000 at 04:08:39PM -0500, Brad Parker wrote:
>
> Gabriel Ricard wrote:
> ...
> >I'm looking to write a device driver for my Keyspan
> >USB -> Mac Serial adapter so I can attempt to use my
> >DeLorme GPS device under Linux (another step to aid me
> >in eliminating my need for MacOS). I think I posted to
> >this mailing list a while back asking for info, I'm
> >not sure.
>
> I want to do the same.  I contacted Keyspan and they said "huh -
> interesting" and I've heard nothing since.  That was 2-3 weeks ago.
>
> The 2 port keyspan fob I have (USA28X) uses the Anchor EXUSB chip.
> This means it needs code downloaded to it.  My hope was that Keyspan
> would release a binary image (srecs) of their code load and we could
> include it in the Linux driver.  This assumes they use a standard USB
> interface to the serial ports...

Unfortunately there's no standard for USB serial ports.

--
Vojtech Pavlik
SuSE Labs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
