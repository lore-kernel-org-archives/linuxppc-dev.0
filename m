Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Wed,  9 Jun 2004 09:56:29 -0300
Message-Id: <HZ1LA5$9EA97153A3F2D2EC1AD72AC1798B6528@bol.com.br>
Subject: Re: ioctl(TIOCMGET) on Lite5200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "saurosalomoni" <saurosalomoni@bol.com.br>
To: "wd" <wd@denx.de>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In message
<HZ0056$6237825DE310949AB818EA81D16B09F0@bol.com.br> you
wrote:
> >
> > I'm having a problem with a specific argument of the
> > ioctl function, which is ioctl(TIOCMGET).
> > I wrote a simple routine which just reads or writes the
> > RTS pin.
> > It worked OK on my Red Hat 9, under x86, but when I try
> > to run it on a Lite5200 using denx kernel 2.4-25, it
> > keeps saying "TIOCMGET failed: Invalid argument" and
>
> Well, that says it all: the TIOCMGET ioctl() is not
available for the
> 5200's PSC uart driver.
>
> Best regards,
>
> Wolfgang Denk

So, if the 5200 series don't support TIOCMGET and
TIOCMSET ioctl() (nor TIOCMBIS and TIOCMBIC, I've just
tried them), what could I possibly use to get/set the
control pin RTS in my Lite5200?...
Is there any other system call or function that
accomplishes that?

Thank you very much.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
