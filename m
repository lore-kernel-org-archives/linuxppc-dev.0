To: "Ho Lee" <flylist@linuxkernel.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SPI driver for MPC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Aug 2004 18:05:30 PDT."
             <05ca01c478f5$f93fb8c0$1502a8c0@corp.skystream.com>
Date: Tue, 03 Aug 2004 08:51:04 +0200
Message-Id: <20040803065109.7A505C109F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <05ca01c478f5$f93fb8c0$1502a8c0@corp.skystream.com> you wrote:
>
> Is SPI driver available for MPC8260 platform? I couldn't find
> either from Linux PPC kernel bitkeeper nor from internet.
> Has someone ported the drvier from u-boot? Otherwise,
> I need to write one.

See arch/ppc/8260_io/cpm_spi.c in our CVS tree.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"You'll pay to know what you really think."        - J.R. "Bob" Dobbs

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
