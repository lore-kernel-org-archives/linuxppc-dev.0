To: "Sarnath Kannan" <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DINK - the downloader ! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "22 Nov 2001 12:21:32 GMT."
             <20011122122132.18969.qmail@mailweb26.rediffmail.com>
Date: Thu, 22 Nov 2001 14:17:13 +0100
Message-Id: <20011122131718.999A6F9BA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Sarnath,

in message <20011122122132.18969.qmail@mailweb26.rediffmail.com> you wrote:
>
>  I am really impatient with the way DINK downloads
> the kernel over the serial line..
>  i just want to get rid of it..
>
> Is it possible to download a "Ethernet boot"
> utility thru which I can download the kernel
> via ethernet card. Any such utilities for the
> sandpoint platform are available.. ?

Use PPCBoot.

I'm not sure how good the Sandpoint support is  at  the  moment,  but
it's  there,  and  it compiles, and some people say they actually use
it.

>  Whats "tftp" and How do I set it up ?

Trivial File Transfer Protocol.

> (no RTFMs please...)

Ummm... but this _is_ a RFTM job.

Or ask your friendly network administrator :-)

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You may call me by my name, Wirth, or by my value, Worth.
- Nicklaus Wirth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
