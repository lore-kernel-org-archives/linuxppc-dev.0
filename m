To: Stefan Nickl <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 08 Jul 2004 13:57:17 +0200."
             <1089287836.6000.46.camel@lucy.pep-kaufbeuren.de>
Date: Thu, 08 Jul 2004 14:12:55 +0200
Message-Id: <20040708121300.75EA7C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Stefan,

in message <1089287836.6000.46.camel@lucy.pep-kaufbeuren.de> you wrote:
>
> I now found out why my picture looked so dim...
> My trusty old CRT was finally broken. ARG!

:-(

> Ok, but the picture from the console (penguin, messages ...)
> is still very blue-ish; however X is perfectly ok with
> the accelerated driver, so with the above said by you,
> it this what I have to expect?

No, colors should be fine on the console, too. Are you sure  you  are
using  the  latest  kernel  drivers?  Note that there are both kernel
modifications plus the X11 driver.

> I understand that console messages on the VGA are not
> important for an embedded system when the apps (can)
> work correctly.

They are important in may cases, and they should be OK. At least this
is working fine here.

There is a Linux kernel image on our FTP server which you could  give
a try:

ftp://adm:PASSWORD@www.denx.de/ftp/pub/fujitsu/Coral-P/uImage-LITE5200

> Btw: "fbset -depth 24" and bootargs+="video=mb86290:1024x768-24@70"
>      apparently have no effect at all...

Ummm.. I will check this...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If A equals success, then the formula is A = X + Y + Z. X is work.  Y
is play. Z is keep your mouth shut.                 - Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
