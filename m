To: "Alexander J" <Alexander.J@lntinfotech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: "bootargs" environment variable -Reg 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Feb 2003 17:43:17 +0530."
             <OF7085AB2C.7CB5F4E6-ON65256CD7.0042E3C3@lntinfotech.com>
Date: Mon, 24 Feb 2003 22:12:39 +0100
Message-Id: <20030224211244.A3493C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OF7085AB2C.7CB5F4E6-ON65256CD7.0042E3C3@lntinfotech.com> you wrote:
>
> I am trying to load the linux kernel to the PPC 405 target board.
> Can some one explain to me the parameters which need to be set for the
> "bootargs" enivironment variable.

See  the  description   for   Linux   command   line   arguments   in
Documentation/kernel-parameters.txt   and   other  files,  especially
Documentation/nfsroot.txt


Also  feel  free  to  see  the  examples  as  used  in  the  DPLG  at
http://www.denx.de/re/DPLG.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
grep me no patterns and I'll tell you no lines.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
