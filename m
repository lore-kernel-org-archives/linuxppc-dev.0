From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>,
	<en_ch@libero.it>
Cc: "Linux-Atm-General@Lists. Sourceforge. Net" <linux-atm-general@lists.sourceforge.net>
Subject: RE: ATM UTOPIA structure initialization sequence for linux
Date: Fri, 21 Mar 2003 15:58:39 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJEEPMCOAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <HC3SPD$4C386C318A714AF18699E2F7DD3FCC76@libero.it>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, en_ch. (?)

Actualy I can't answer your question but why don't you have a look at
http://sourceforge.net/projects/mpc860sar/ from Alex Zeffertt.
It works quite well on my system so it looks like the did use a good initialization order.

Regards, Stephan


> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of
> en_ch@libero.it
> Sent: Freitag, 21. März 2003 15:39
> To: linuxppc-embedded
> Subject: ATM UTOPIA structure initialization sequence for linux
>
>
>
> i have to realize a char driver to set ATM Utopia for a linux
> embedded system using motorola mpc850sar.
>
> Anyone knows if there is - and which is - a correct ATM UTOPIA structure (buffer, BDs, CTs, APC )initialization sequence
> for linux ?  my code running stopped after starting utopia, and i start utopia after structure init. I have seen every
> register setting is correct so i think its initialization sequence order.
> thanks
> en_ch
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
