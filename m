To: Jaap-Jan <jjboor@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: occasionally segmentation faults 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 31 Jul 2002 12:28:38 +0200."
             <200207311028.MAA25657@hzsms01.nl.lucent.com>
Date: Wed, 31 Jul 2002 13:18:05 +0200
Message-Id: <20020731111810.B306010876@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200207311028.MAA25657@hzsms01.nl.lucent.com> you wrote:
>
> I've some problems with my built cross environment
> from sparc-solaris to powerpc 8xx.
>
> I configured and built gcc2.95.2 and glibc-2.1.3
> and used that to build the file and sh utils etc.

These versions are pretty old.

Why don't you use our ELDK,  which  is  available  for  Solaris  host
environment, too? It's working fine...

See http://www.denx.de/ELDK/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
An age is called Dark not because  the  light  fails  to  shine,  but
because people refuse to see it.           -- James Michener, "Space"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
