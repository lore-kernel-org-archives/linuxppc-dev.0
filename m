To: acurtis@onz.com
Cc: "Flavio Pereira" <fpereira@azisa.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 8260 using ELDK..Help?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Sep 2002 06:58:31 PDT."
             <NCBBIINEHIPFGJPLBEIFGEKFDLAA.acurtis@onz.com>
Date: Wed, 04 Sep 2002 18:08:02 +0200
Message-Id: <20020904160807.7E5BF11835@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NCBBIINEHIPFGJPLBEIFGEKFDLAA.acurtis@onz.com> you wrote:
>
> > Did you fix the IMMR mapping in PPCBoot? The  CFG_DEFAULT_IMMR  defi-
> > nition  will  NOT  work with LInux; see the Linux memory map require-
> > ments - You _must_ map the IMMR at 0xF0000000 or above.
>
> If he got this far in the boot, the IMMR is working.

You are wrong. If he uses the IMMR default value  of  0x0F010000  the
kernel  will  crash  as  soon as it starts executing application code
(because of overlapping address ranges).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Each honest calling, each walk of life, has its own  elite,  its  own
aristocracy based on excellence of performance. - James Bryant Conant

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
