Message-ID: <3BA8CD96.75D27252@mvista.com>
Date: Wed, 19 Sep 2001 09:53:42 -0700
From: Brian Eliot <beliot@mvista.com>
MIME-Version: 1.0
To: Kevin Fry <kevin@carts.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Init acting strange
References: <001e01c140ac$88e8b830$fb5a01d9@crtc.corp.mot.com> <3BA7FE96.CA24D4EE@carts.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I've been trying to get init working for a while now but I can't getting
> logging in to work correctly, and I'm out of ideas, maybe someone can help
>
> I'm using HHL 2.0 and the ramdisk is made from the target app rpms. I'm using
> the default passwd file. Do shadow passwords or anything like that need to be
> compiled in the kernel for the hhl2.0 login stuff to work??
>
> here's what I'm seeing:
>
>   MontaVista Software's Hard Hat Linux 2.0
>
>   (none) login: root
>
>   MontaVista Software's Hard Hat Linux 2.0
>   ...

A read-only root filesystem (or filesystem read-only to write attempts by root)
will cause this symptom.
--
Brian Eliot	MontaVista Software, Inc.	E-mail:	beliot@mvista.com
		1237 E. Arques Avenue		Voice:	+1 408 992 4712
		Sunnyvale, CA  94085-4701	Fax:	+1 408 328 9204

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
