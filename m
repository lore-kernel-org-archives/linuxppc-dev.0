To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: Subodh Nijsure <subodh@best.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: flash writing with Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Mar 2001 18:16:26 +0100."
             <3AB63EEA.987DC654@esd-electronics.com>
Date: Mon, 19 Mar 2001 18:35:03 +0100
Message-Id: <20010319173508.BF76528A9B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AB63EEA.987DC654@esd-electronics.com> Matthias Fuchs wrote:
>
> > Perhaps you can take a look at mtd and use that to manage your flash.
> > With mtd you can partition your flash to different devices and erase them
> > selectively.
> What is mtd ? Never heard of before !

Memory Technology Devices.

> > Once you have your flash partitioned you can simply cat a file to /dev/mtd#
> > to copy new content to the flash.
> That sounds nice and seems to be same like the stuff Wolfgang offered in
> his 2.4.3-preX patch.

Yes, there is a significant overlap in functionality.

I intend to drop support for our driver once MTD is working.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Oh dear, I think you'll find reality's on the blink again."
- Marvin The Paranoid Android

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
