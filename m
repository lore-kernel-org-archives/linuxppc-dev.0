Reply-To: <fred@sc23.sc.mcel.mot.com>
From: "Liu Fred-a18596" <a18596@email.mot.com>
To: "'Mark Hatle'" <fray@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: can newlib be a shared library on ppc platform?
Date: Thu, 5 Dec 2002 09:13:47 +0800
Message-ID: <002a01c29bfb$90c82e90$940879c8@sc.mcel.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <3DEBEB39.6040701@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found a tool at
http://oss.software.ibm.com/developer/opensource/linux/projects/minilibc/,
with it I have tailored standard glibc2.1.3 to less than 500K. It meets our
requirements.


-----Original Message-----
From: Mark Hatle [mailto:fray@mvista.com]
Sent: Tuesday, December 03, 2002 7:23 AM
To: Liu Fred-a18596
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: can newlib be a shared library on ppc platform?

Liu Fred-a18596 wrote:
> Hi,
>
> I need a small libc in our embedded system, so I compiled newlib.
> But it seems that newlib only support static library on ppc platform.
> Is it true?

I believe newlib is barely a C library, (it was the last time I looked at
it)

I would suggest you investigate uclibc and see if that will do what you
need.
(There is a version of uclibc that will do shared libs, but I do not know
how
advanced the dynamic loader is on PPC.)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
