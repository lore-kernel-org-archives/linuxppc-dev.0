To: "navinb" <ppc4@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: initialing BRGC1 for usb 1 ms SOF generation gets hanged.. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "20 May 2002 13:56:09 -0000."
             <20020520135609.18471.qmail@webmail16.rediffmail.com>
Date: Mon, 20 May 2002 17:28:02 +0200
Message-Id: <20020520152807.EAAA41196D@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020520135609.18471.qmail@webmail16.rediffmail.com> you wrote:
>
> I am using brg1 for 1 ms sof generation.
>
> as soon as i initialise the brgc1 with appropiate value
> it gets hanged.
>
> what could be possible reasons for this..

Maybe BRG1 is already in use? For instance, for some serial port like
the serial console?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Documentation is like sex: when it is good, it is  very,  very  good;
and when it is bad, it is better than nothing.         - Dick Brandon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
