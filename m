Date: Thu, 13 Jun 2002 14:50:32 +0200
From: Xavier Grave <grave@ipno.in2p3.fr>
To: Gerhard TAEUBL <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: debian installation on an embedded system
Message-ID: <20020613145032.C4925@ipnpcu5.in2p3.fr>
References: <sd085559.000@mail.frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <sd085559.000@mail.frequentis.com>; from Gerhard.TAEUBL@frequentis.com on jeu, jun 13, 2002 at 08:18:11 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
