To: cedric_aubert@yahoo.fr
Cc: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uClibc Compiling problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Apr 2003 08:22:33 PDT."
             <20030414152233.13543.qmail@web41803.mail.yahoo.com>
Date: Mon, 14 Apr 2003 17:50:26 +0200
Message-Id: <20030414155031.AA22AC58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030414152233.13543.qmail@web41803.mail.yahoo.com> you wrote:
>
> Does anyone known why the file crtbeginS.o is absent
> in the
> ELDK 2.0.2 cross compiling tools (mpc860) ?

If you installed the  ELDK  (at  least  the  ppc_8xx  package)  under
/opt/eldk, there should be a file

/opt/eldk/ppc_8xx/usr/lib/gcc-lib/ppc-linux/2.95.4/crtbeginS.o

on your system. Please check again.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It is surely a great calamity for  a  human  being  to  have  no  ob-
sessions.                                                - Robert Bly

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
