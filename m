MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: System crash in kernel_thread 
Date: Wed, 4 Jun 2003 09:04:16 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD39FEA1@srv-mailrnd.azisa.co.za>
From: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
To: "Jean-Denis Boyer" <jdboyer@m5t.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I experienced a similar problem with my 860 based board.
>The solution was in DER (Debug Enable Register) configured by the BDI.
>I had to remove a bit, I just don't remember which one.


Thanks, that solved it, I had to clear the SYSIE in the Debug Enable
register.

Regards
Flavio Pereira

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
