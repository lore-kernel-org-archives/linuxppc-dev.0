Message-ID: <3AE9972D.FEF28339@nexus-tech.net>
Date: Fri, 27 Apr 2001 11:58:37 -0400
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [Ppcboot-users] 16 Bit wide Flash on MPC8xx]
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Geir Frode Raanes wrote:

[..snip..]

> to DQ_mpc8xx[31..24(#WE3), 23..16(#WE2)]/#OE(GPL1)/#CS0
> http://www.amd.com/products/nvd/techdocs/21415.pdf)

Is this signal numbering mpc style (0 = MSB)? If so, shouldn't this be
D0..D7(#WE0) and D8..D15(#WE1)? We're getting ready to spin hardware and
I want to make sure I understand this correctly.

Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
