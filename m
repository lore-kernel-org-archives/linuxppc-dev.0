From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: Steve Boorman <steveb@baydel.com>
Subject: Re: Hangup booting Linux on PPC440GP
Date: Tue, 15 Jul 2003 09:15:30 +0200
References: <3F12E900.23193.19E927F@localhost>
In-Reply-To: <3F12E900.23193.19E927F@localhost>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200307150915.31054.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Am Montag, 14. Juli 2003 18:31 schrieb Steve Boorman:
> Everything looks good until Linux attempts to run /sbin/init, then the
> machine hangs up, no panic or anything else displayed on the console.

Sounds like our problem with a 405GP cpu. Has the 440GP also an embedded SRAM?
Where do you have locate it? Below or above 0x8000'0000? Locate it above
0x8000'0000 (on 405GP the SRAM uses virtual addresses, below 0x8000'0000 it
disturbes any user tasks...)

Hope it helps
--JB

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
