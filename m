Message-ID: <3B97A628.F21AD85D@mvista.com>
Date: Thu, 06 Sep 2001 11:36:56 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Navin Boppuri <navin.boppuri@newisys.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Ctrl-C works just fine.
References: <3A494DE356A49A40B37442E1E0D9F3B5063440@ptah.ad.newisys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Navin Boppuri wrote:
>
> Ctrl-C works just fine on everything now, thanks to Cal Erickson. The
> trick is to make /dev/console a symbolic link to ur serial port
> /dev/ttyS0 or S1.
>
> Navin.

Just keep in mind that, if your /dev/ttyXX device does not (by default)
turn on the control-c stuff it won't work.  There are/were a few serial
port drivers that did not do this by default, so you may experience the
same problem.

--Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
