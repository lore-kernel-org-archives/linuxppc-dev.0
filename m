Message-ID: <386A4E90.21B2D0D7@netx4.com>
Date: Wed, 29 Dec 1999 13:10:24 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: pcmcia-cs for 8xx
References: <Pine.LNX.3.96.991229095842.12905A-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark S. Mathews wrote:
> 
> I'm not aware of pcmcia-cs for 8xx, we just have some kernel routines that
> we wrote to initialize the 8xx pcmcia registers.  They're not as generic
> as I'd like yet, but you're welcome to them.


How about if I combine these with functions I have, and try
to make something generic for low-level RPX-Lite boards?  At
least it is a starting point and we can improve it over time.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
