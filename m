To: "Kevin P. Dankwardt" <k@kcomputing.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: remote access via shell 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Mar 2004 08:20:37 CST."
             <KCEOLLHGFJIAFNAMGACHEEPJDFAA.k@kcomputing.com>
Date: Tue, 09 Mar 2004 16:14:37 +0100
Message-Id: <20040309151442.1E311C0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <KCEOLLHGFJIAFNAMGACHEEPJDFAA.k@kcomputing.com> you wrote:
>
> I have a ppc 5100 that is currently running Linux. I also have downloaded
> and looked at the ELDK. Neither appear to have a telnet nor a ssh daemon.

You didn't look very carefully. telnetd is included with the ELDK as
/usr/sbin/in.telnetd; this is part of the
telnet-server-ppc_???-0.17-23_1 RPM.

> What daemon for remote access is recommended? Are there small versions

Secure Shell of course - if you can afford the size.

> especially appropriate for embedded use? Versions that have Make files
> conducive to cross-compilation for PPC?

;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The evolution of the human race will not be accomplished in  the  ten
thousand  years  of  tame  animals,  but in the million years of wild
animals, because man is and will always be a wild animal.
                                              - Charles Galton Darwin

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
