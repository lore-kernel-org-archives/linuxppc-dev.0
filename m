Message-ID: <38C7DC0B.7567BB9D@email.sps.mot.com>
Date: Thu, 09 Mar 2000 11:14:51 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: USB driver for MPC850/823
References: <38C7D1A7.92DC9BFE@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yep.  I don't do ATM, but the majority of IDMA related questions
can be traced to misalignment issues.  Come to think of it, I
can count the number of DSP function related questions one hand.

Dan Malek wrote:
>
> Richard Hendricks wrote:
>
> > The most famous case of this is the IDMA buffer descriptors.
>
> I don't know about those, but DSP and ATM have 32 and 64 byte alignment
> for various structures.
>
>         -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
