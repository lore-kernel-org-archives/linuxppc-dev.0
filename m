From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Serial port text corruption
Date: Wed, 19 May 2004 19:14:15 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHMEBKCGAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <2EBE5450-A9B4-11D8-BBC2-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I don't think that such a character was entered in my case, but
> > perhaps a
> > random character was generated when connecting the cable?
>
> Well, you are running 115200, what happens if you use some reasonable
> baud rate like 38400 or less?

The problem is very hard to reproduce at will. Trying to veriy if a lower
baud rate solves it is even harder. I will fix the getty problem and se
if it goes away.

> > Any ideas for a replacement getty?
>
> I use mgetty.

OK, thanks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
