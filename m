To: "rick.liu" <dovi@eyou.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kermit:How to disable the flow control signals? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "17 May 2003 18:45:49 +0800."
             <20030517184549.35030.qmail@eyou.com>
Date: Sat, 17 May 2003 19:07:15 +0200
Message-Id: <20030517170720.976B3C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Rick,

in message <20030517184549.35030.qmail@eyou.com> you wrote:
>
> >> 1.why the flow control signals are still "on"?
> >
> >Because this is what you serial  driver  reports  about  the  current
> >state of these pins?
>
> i donnot think so,for example,my NO.7 pin(RTS) and NO.9 pin(RI) both connect
> to nothing,if your conclusion is correct,RTS and RI should be the same
> state.But we
> saw they are not the same.

Do you really know for sure how thse pins are  internally  connected?
If  there  are  any  pull-up  or -down resistors? And how your UART is
implemented internally? And if the driver actually reads the pins?

I wrote: this is what your  serial  driver  reports.  This  does  not
necessarily  mean  that  this is actually the state of the externally
accessable pin on the serial connector...

> here is my info:

This looks ok.

> Now we can still see the RTS/CTS/DSR/CD/DTR are still on,why?

Because this is what you serial  driver  reports  about  the  current
state of these pins?

> it my kermit version's problem?

No.


Ummm... why do you bother? Is anything not working?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A Puritan is someone who is deathly afraid that  someone,  somewhere,
is having fun.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
