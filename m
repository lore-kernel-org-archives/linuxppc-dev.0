Message-Id: <200101282017.MAA19462@mail.turbolinux.com>
Date: Sun, 28 Jan 2001 20:25:07 -0000
To: Iain Sandoe <iain@sandoe.co.uk>, brad@turbolinux.com,
        linuxppc-dev@lists.linuxppc.org
Subject: pmud monitoring temperature (Re: powerbook doubles)
From: Brad Midgley <brad@turbolinux.com>
Cc: djosg@mgu.bath.ac.uk
Reply-To: brad@turbolinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain,

until we have proper heat control in the kernel, maybe pmud should monitor the temperature and put
the machine to sleep if it runs too hot.

> > /proc/cpuinfo does not report the temperature (i'm not sure the hardware
> > can report it).
>
> yes, it can.
> Someone posted a patch some time last year to get the info into the /proc
> entry.  If that no longer applies it shouldn't be too difficult to update
> it.

i found it and i'll try to apply it today:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200009/msg00365.html

thanks
brad

--
Brad
brad@turbolinux.com      http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
