To: "saurosalomoni" <saurosalomoni@bol.com.br>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ioctl(TIOCMGET) on Lite5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Jun 2004 13:22:18 -0300."
             <HZ0056$6237825DE310949AB818EA81D16B09F0@bol.com.br>
Date: Tue, 08 Jun 2004 19:23:25 +0200
Message-Id: <20040608172330.D9967C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <HZ0056$6237825DE310949AB818EA81D16B09F0@bol.com.br> you wrote:
>
> I'm having a problem with a specific argument of the
> ioctl function, which is ioctl(TIOCMGET).
> I wrote a simple routine which just reads or writes the
> RTS pin.
> It worked OK on my Red Hat 9, under x86, but when I try
> to run it on a Lite5200 using denx kernel 2.4-25, it
> keeps saying "TIOCMGET failed: Invalid argument" and

Well, that says it all: the TIOCMGET ioctl() is not available for the
5200's PSC uart driver.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A right is not what someone gives you; it's what no one can take from
you.                                                   - Ramsey Clark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
