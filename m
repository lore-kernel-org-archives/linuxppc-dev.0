To: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging Init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Dec 2002 18:04:31 PST."
             <0509218DDAD7D6118055006008F6D5F6A1E3A6@postal.viasat.com>
Date: Wed, 11 Dec 2002 09:49:32 +0100
Message-Id: <20021211084937.C79DCC613A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0509218DDAD7D6118055006008F6D5F6A1E3A6@postal.viasat.com> you wrote:
> Thanks for the input. I finally got the board up. It was due
> to the my compilation of busybox with the -nostdlib option and
> explicitly linking the necessary libs (warning of not finding _start). I
> also noticed the
> floating point emulation was off in the kernel.

...which is OK. You should not enable it.

> Does anyone have a good explanation of the _start as the entry
> symbol for an application? This seemed to be my problem when I originally

This must be the rsult from your build process. I don't see this  wih
busybox.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Overdrawn?  But I still have checks left!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
