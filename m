Message-ID: <3DEBEB39.6040701@mvista.com>
Date: Mon, 02 Dec 2002 17:22:33 -0600
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Liu Fred-a18596 <fred.liu@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: can newlib be a shared library on ppc platform?
References: <89DEFCC5DB33D411A27F00508BCF8A820A16F93F@ZCH07EXM05.corp.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Liu Fred-a18596 wrote:
> Hi,
>
> I need a small libc in our embedded system, so I compiled newlib.
> But it seems that newlib only support static library on ppc platform.
> Is it true?

I believe newlib is barely a C library, (it was the last time I looked at it)

I would suggest you investigate uclibc and see if that will do what you need.
(There is a version of uclibc that will do shared libs, but I do not know how
advanced the dynamic loader is on PPC.)

--Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
