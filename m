To: acurtis@onz.com
Cc: kumar.gala@motorola.com, pkanthi@yahoo.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC 405 port complains about 'tlbwe' opcode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Oct 2002 15:52:38 PDT."
             <20021024155238.7207.h007.c007.wm@mail.directvinternet.com.criticalpath.net>
Date: Fri, 25 Oct 2002 01:14:14 +0200
Message-Id: <20021024231419.4EF821014C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021024155238.7207.h007.c007.wm@mail.directvinternet.com.criticalpath.net> you wrote:
>
> > Actually the cross compiler should automatically  set  the  necessary
> > options  for  the  target,  or you might run into problems because of
> > missing or inconsistent options for your compiles (kernel, libraries,
> > applications) - "-msoft-float"  is  another  candidate  for  such  an
> > option.
>
>
> This is a problem if you created your own cross compiler with GCC 2.95.3. I
> understand this has been fixed in newer versions. Perhaps this is fixed in the
> denk version? I know that the MontaVista distributions fixed this problem.

I know that we fixed it in the ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It is better to have tried and failed than to have  failed  to  try,
but the result's the same."                           - Mike Dennison

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
