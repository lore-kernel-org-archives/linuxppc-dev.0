Message-Id: <200003032108.QAA25344@p2.parker.boston.ma.us>
To: Gabriel Ricard <g_ricard@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org, linux-usb@suse.com
Subject: Re: USB Device Driver Development Resources
In-reply-to: Your message of "Fri, 03 Mar 2000 10:07:57 PST."
             <20000303180757.9695.qmail@web1704.mail.yahoo.com>
Date: Fri, 03 Mar 2000 16:08:39 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Gabriel Ricard wrote:
...
>I'm looking to write a device driver for my Keyspan
>USB -> Mac Serial adapter so I can attempt to use my
>DeLorme GPS device under Linux (another step to aid me
>in eliminating my need for MacOS). I think I posted to
>this mailing list a while back asking for info, I'm
>not sure.

I want to do the same.  I contacted Keyspan and they said "huh -
interesting" and I've heard nothing since.  That was 2-3 weeks ago.

The 2 port keyspan fob I have (USA28X) uses the Anchor EXUSB chip.
This means it needs code downloaded to it.  My hope was that Keyspan
would release a binary image (srecs) of their code load and we could
include it in the Linux driver.  This assumes they use a standard USB
interface to the serial ports...

I pawed around their macintosh driver and didn't see any obvious code
in it - I didn't use resedit, however, so their might have been some
resources in the file I didn't see (I'm an ancient mac programmer - do
mac files still have two forks and resources ? do people still use
resedit?  am I showing my age?)

Anyway, I'd call their tech support and ask for help.  Maybe if
several of us do it they'll help out...

I'm tempted to reverse engineer it, or maybe start with a USBStick,
which looks fairly similar and make my own code down load.  But that's
probably a pipe dream :-)

-brad

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
