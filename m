Message-Id: <sd08c3de.074@mail.frequentis.com>
Date: Thu, 13 Jun 2002 16:09:34 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <grave@ipno.in2p3.fr>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: debian installation on an embedded system
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

Well this seems to be OK. But I think it doesn't start the scripts stored in /etc/rc2.d. It printed Entering Init level 2 (or similar...)  and then the login apears.

Gerhard

>>> Xavier Grave <grave@ipno.in2p3.fr> 06/13/02 02:50pm >>>

Le jeu, 13 jun 2002 08:18:11, Gerhard TAEUBL a écrit :
>
> Hi!
>
> I try to do this like Kenneth described it (see
> http://lists.linuxppc.org/linuxppc-embedded/200103/msg00106.html).
> I used an own design with an mpc860Tand the console on SCC2.
>
> It works fine till the login. If I enter root the login apears again, and
> so on, no request for password. The system is stored on an IMac, so I use
> the password file from the mac (debian 2.2).
>
> Any ideas?
Hi,

Did you check the file /etc/securetty ?
Perhaps this is a security problem..

O+ xavier
--
33 (0) 1 69 15 79 59
De chacun selon ses forces, a chacun selon ses besoins


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
