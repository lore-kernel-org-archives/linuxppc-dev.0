To: Miku Jha <jha_miku@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cross compiling gdb for ppc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 10 Jul 2003 21:57:49 PDT."
             <20030711045749.4201.qmail@web40306.mail.yahoo.com>
Date: Fri, 11 Jul 2003 09:02:46 +0200
Message-Id: <20030711070251.DEC2EC6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030711045749.4201.qmail@web40306.mail.yahoo.com> you wrote:
>
> When I run the gdb to debug the core file it somehow
> refers to the libraries in the /lib path
> the libraries for my target machine are somewhere
> else.
>
> I wanted to know if there is any option or workaround
> to make gdb point to correct libraries.

RTFM.

See especially the "solib-absolute-prefix" variable.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
What the gods would destroy they first submit to  an  IEEE  standards
committee.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
