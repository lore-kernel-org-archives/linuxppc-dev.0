Date: Tue, 15 Oct 2002 12:58:57 -0400
From: Kurt Wall <kurt.wall@timesys.com>
To: gguevel <gguevel@interfaceconcept.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problem with module installation under 2.4.x kernel
Message-ID: <20021015125857.I1562@timesys.com>
References: <000001c27467$6fd3cc00$3101a8c0@DOMAIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c27467$6fd3cc00$3101a8c0@DOMAIN>; from gguevel@interfaceconcept.com on Tue, Oct 15, 2002 at 06:25:11PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Speaking on condition of anonymity, gguevel told us:
>
> I worked under Linux 2.2.x Kernel and I have no problem with the module
> generation.
>
> Now under Linux 2.4.x Kernel, I can compile modules and install them but
> I have the following warning while running "insmod xxxx"
> Warning: loading xxxx will taint the kernel: no license.
>
> Does anyone know what I must add to my module to avoid this warning ?

Putting

MODULE_LICENSE("GPL");

somewhere in the module source code should do nicely. Providing,
of course, that you wish to GPL your module.

Kurt
--
Q:	What is the difference between Texas and yogurt?
A:	Yogurt has culture.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
