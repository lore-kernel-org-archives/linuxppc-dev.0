Message-ID: <20083A3BAEF9D211BDB600805F8B14F3010A15AE@NTSERVER>
From: Tzahi Oved <tzahio@voltaire.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: ppcboot 1.1.4 & MPSC
Date: Tue, 26 Feb 2002 23:03:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Well, to cancel any baud rate problems I zeroed the CDV field in the BRG
register so it defaults to 115000. So when I use the ppc boot as is with
MPSC uart and baud rate of 115000, I listen to the Tx line with a scope and
see nothing !, what am I doing wrong ??

-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de]
Sent: Tuesday, February 26, 2002 3:18 PM
To: Tzahi Oved
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: ppcboot 1.1.4 & MPSC


In message <20083A3BAEF9D211BDB600805F8B14F3010A15AB@NTSERVER> you wrote:
>
> I'm trying to work with the internal uart (MPSC) on the Galileo EVB64260
> board. When I set the definition CONFIG_MPSC in the EVB64260 config file
> (which supposed to set the terminal to work on the MPSC) I'm not getting
any
> response on my console, do I need to configure anything else ?? any

This can be anything, like just bad baudrate settings. You need to be
more specific about your setup.

And you have better chances for a useful reply on  the  ppcboot-users
mailing list.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Cole's Law: Thinly sliced cabbage.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
