To: Julien EYRIES <julien.eyries@thales-bm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: search for LCD pannel (1x16 or 2x16) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 25 Sep 2002 11:22:56 +0200."
             <3D918070.10009@thales-bm.com>
Date: Wed, 25 Sep 2002 22:47:48 +0200
Message-Id: <20020925204753.1C43AFA8E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D918070.10009@thales-bm.com> you wrote:
>
> I'm searching for a LCD panel ( about 1x16 or 2x16 characters, black and
> white only ) that my MPC8260 could use  .

Most display of this sort come with some sort of serial interface.

> Is there some support for them in the linux kernel (I use linux 2.4.4
> from Denx) ?

The UART driver is working just fine...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hi there! This is just a note from me, to you, to tell you, the  per-
son  reading this note, that I can't think up any more famous quotes,
jokes, nor bizarre stories, so you may as well go home.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
