Message-ID: <3439AB3A99ECD5409F3A52ACF814744D158DA2@norcom2.norcom.net>
From: Lokesh Kumar <kumar.lokesh@wrx-us.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>,
	Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: mpc8xx memory mapped 16550A uart garbage
Date: Thu, 16 Oct 2003 16:14:51 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks Steven,
The problem turned out to be my hardware fixture for testing 16550A. So, I
traced it and fixed and it works now.

Lokesh

-----Original Message-----
From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
Sent: Thursday, October 16, 2003 3:08 AM
To: Lokesh Kumar
Cc: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Re: mpc8xx memory mapped 16550A uart garbage


Lokesh,

> I did measure the bit width and that is around 104us, which is correct.
> Anything else?

Hmm. I suppose you tried sending only character again and again and verified

that your board is indeed sending this character over the lines by looking
at
the scope...


Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
