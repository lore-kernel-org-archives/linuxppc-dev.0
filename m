Message-Id: <200011281950.eASJoPL03212@denx.local.net>
To: Kyle Harris <kharris@nexus-tech.net>
cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: fb on mpc823 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 28 Nov 2000 14:15:45 EST."
             <3A240461.10B69DF3@nexus-tech.net>
Date: Tue, 28 Nov 2000 20:50:25 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A240461.10B69DF3@nexus-tech.net> you wrote:
>
> Thanks, this makes more sense. But I'm still having problems. I'm
> running 2.2.13 on a TQM823 board. I updated lcd823.c and rebuilt the
> kernel with fb and vt support. Now I get a kernel panic (listed below).
...
> I guess it's time to figure out how to interpret and debug kernel
> panics. Any suggestions on where to start?

Try switching to 2.2.14 first; the necessary changes for the  TQM8xxL
are available on our FTP server - see
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.2.14*

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Where people stand is not as important as which way they face.
        - Terry Pratchett & Stephen Briggs, _The Discworld Companion_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
