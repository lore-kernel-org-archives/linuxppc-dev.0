To: Brian Kuschak <bkuschak@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bdi problem with 4xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 08 Jul 2003 10:19:11 PDT."
             <20030708171911.26511.qmail@web40911.mail.yahoo.com>
Date: Tue, 08 Jul 2003 23:39:34 +0200
Message-Id: <20030708213939.99DDCC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030708171911.26511.qmail@web40911.mail.yahoo.com> you wrote:
>
> - TARGET: processing target startup ....
> *** TARGET: processing target startup failed
> # PPC: timeout while waiting for freeze
> - TARGET: target will be restarted in 10 sec
> BDI>
>
> Even a minimal configuration file has the same
> problem.  I'm waiting to hear back from Abatron, but
> maybe someone here knows the solution??

This may be a hardware problem, but more often it is just an error in
your config file. Bt without knowing the  hardware  and  your  config
file there is little we can do...


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The X11 source code style is ATROCIOUS and should not be used  as  a
model."                                                   - Doug Gwyn

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
