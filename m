To: Allen Curtis <acurtis@onz.com>
Cc: "Ppc Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: IBM405/Linux Cross compiler 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Jun 2002 20:45:18 PDT."
             <NCBBIINEHIPFGJPLBEIFCEDLDJAA.acurtis@onz.com>
Date: Sat, 29 Jun 2002 21:51:35 +0200
Message-Id: <20020629195140.3EFDA10341@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Allen,

in message <NCBBIINEHIPFGJPLBEIFCEDLDJAA.acurtis@onz.com> you wrote:
>
> I have tried to build a cross compiler for the IBM405 processor under
> Linux/x86. After much playing, I have decided that the problem is not a
> compiler or linker problem but rather a configuration/installation issue.
> The problem that I am having is that there are some 403/405 specific
> pneumonics that are not recognized by the assembler. (as installed) The
> problem appears to be that the option:

You can download a complete and _working_ set  of  cross  and  native
tools  (our  ELDK = Embedded Linux Development Kit) for free; you can
also use our build scripts  and  patches  to  build  the  tools  from
scratch if you like - see the documentation at
http://www.denx.de/ELDK/

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Business is like a wheelbarrow. Nothing ever happens until you  start
pushing.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
