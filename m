From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15945.36122.671574.509514@argo.ozlabs.ibm.com>
Date: Wed, 12 Feb 2003 10:54:02 +1100
To: joakim.tjernlund@lumentis.se
Cc: Dan Malek <dan@embeddededge.com>,
	Murray Jensen <Murray.Jensen@csiro.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: [PATCH] 8xx_io/uart.c
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKECPFKAA.joakim.tjernlund@lumentis.se>
References: <3E491EE8.6070503@embeddededge.com>
	<IGEFJKJNHJDCBKALBJLLKECPFKAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund writes:

> I think I know why the are as they are now. KGDB/XMON stuff is messy and if you
> are sure that XMON/KGDB never outputs a LF all is fine.

Well I can tell you for a fact that xmon will output \n.

Dan, the code looks fragile as it is - why shouldn't the second part
(inside the if (*s == 10) body) do the same test as the first part?
Relying on xmon/kgdb never outputting \n sounds like a bad idea to me.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
