Message-ID: <014c01c43dc3$86cc0090$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <BCEFJBPJCGFCNMMMIDBHGEBICGAA.Joakim.Tjernlund@lumentis.se>
Subject: Re: Serial port text corruption
Date: Wed, 19 May 2004 13:05:42 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > I am using agetty and I have just read that agetty tries to figure
> > out parity settings during login and sets the tty accordinly...
>
> Any ideas for a replacement getty?
>

My inittab (from ELDK) has 'mingetty' which has never given me any problem.
It apparently just keeps the current baud and parity settings.

Mark Chambers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
