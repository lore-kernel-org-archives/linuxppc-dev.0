Message-ID: <20000526111141.D9365@lx.c-side.com>
Date: Fri, 26 May 2000 11:11:41 -0700
From: Neil Russell <caret@c-side.com>
To: "Gessner, Matt" <mattg@aiinet.com>
Cc: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: EST SBC8260 Question
References: <7283DE19D141D111AD0E00A0C95B195502581D59@mail2.aiinet.com> <392EA01D.CAC477EB@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <392EA01D.CAC477EB@embeddededge.com>; from Dan Malek on Fri, May 26, 2000 at 12:02:37PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, May 26, 2000 at 12:02:37PM -0400, Dan Malek wrote:
> > Can anyone who's using this board please shed some light
> > on what's going on?
>
> It depends upon the type of DIMM you are using.  Mine has the 2M x 64
> DIMM, so it uses only /CS2 to get the 16 Mbyte space.  It also depends
> upon the DRAM controller configuration.  Make sure you have the DRAM
> controller properly configured to route the address lines.


The vxWorks BSP expects a stick with one bank of 16MB SDRAM.  If you didn't
get such a stick from EST, I'd go back and complain.  Alternatively, you
could put a stick in that has a bank that is at least 16MB.  I have a 128MB
stick in mine and it happily pretends to be 16MB.


Neil.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
