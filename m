To: Julien Eyries <julien.eyries@thales-bm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Re: kernel command line for CRAMFS root filesystem] 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 06 Jun 2002 18:51:08 +0200."
             <3CFF92FC.8070102@thales-bm.com>
Date: Thu, 06 Jun 2002 20:57:54 +0200
Message-Id: <20020606185759.CCEA4102F2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CFF92FC.8070102@thales-bm.com> you wrote:
>
> now it works !!
>
> 1) i have applied by hand the mkcramfs_endian.patch ( i have kernel
> 2.4.4 from denx )

Just for the record: the  mkcramfs  that  comes  with  our  ELDK  has
support for "-r", too.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Everything should be made as simple as possible, but not simpler."
- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
