Date: Thu, 11 Oct 01 12:51:18 PDT
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0110111951.AA28062@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Proposed solution for interrupt mapping on CPCI and PPMC CPU ports
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras <paulus@samba.org> wrote:

> Sounds OK, but I wonder why you want a binary format rather than
> something more easily human-readable?

Well, people can store this information wherever they want in whatever format
they want, but I would much prefer it being passed to the kernel in this simple
binary format rather than implement a parser for some human-oriented text
format in the board support files under arch/ppc/kernel.

--
Michael Sokolov				5791 VAN ALLEN WAY
Software Engineer			CARLSBAD CA 92008-7321 USA
SBS Technologies, Inc.			Phone: +1-760-438-6900 x2347
Communications Products			    or  1-888-SBS-COMM x2347
					Fax:   +1-760-438-6985
					E-mail: msokolov@sbs.com
					     or msokolov@ivan.Harhan.ORG

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
