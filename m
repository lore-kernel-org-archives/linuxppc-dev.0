Message-ID: <3FB423AB.80805@jonmasters.org>
Date: Fri, 14 Nov 2003 00:36:59 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: ppc4xx Ports]
References: <3FB416F9.7080303@jonmasters.org> <20031114002023.GA9509@gate.ebshome.net>
In-Reply-To: <20031114002023.GA9509@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Eugene Surovegin wrote:

| If you have problems with linuxppc-2.4 on 40x hw, report them here :)

Only problem at the moment is that I am reworking some of the pte stuff
to kludge in some of the Montavista code in to 2.4.21 rather than the
homebrew solution I have been using which modifies the bits in hardware
TLB entries from everyone else :-). Some random other bugs too which
amuse me like I can only use half of the TLBs due a known errata with
the Virtex II Pro. The other ports seem to have missed that errata...

Fun.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
