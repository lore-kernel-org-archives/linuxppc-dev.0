To: zjzhou@newrocktech.com
Cc: "'Mailing List: linuxppc-dev'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A question on kernel clock: 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 30 Dec 2003 14:34:36 +0800."
             <000301c3ce9e$ff345440$b702a8c0@newrock2>
Date: Tue, 30 Dec 2003 11:22:30 +0100
Message-Id: <20031230102235.32DD9C12DD@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear John,

in message <000301c3ce9e$ff345440$b702a8c0@newrock2> you wrote:
>
> A question on kernel clock:

I wish you would explain in a bit more detail what you are talking about...

> Normally, which is kernel clock source? Can we use any one of

Normally the kernel clock source is a quartz oscillator.

Or what do you mean? "clock source"  can  mean  different  things  to
different people and may be different on differenrt processors.

The kernel uses the decrementer for the system tick.

> BRG1-8? Can we use bus clock? Which is good for choice?

Use BRG1-8? On which processor? What for?

Good for choice? On which hardware? For which purpose?

> Can anyone give me some suggestions?

Yes: please ask more specific questions.


Best regards, and a Happy New Year!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In general, they do what you want, unless you want consistency.
                                    - Larry Wall in the perl man page

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
