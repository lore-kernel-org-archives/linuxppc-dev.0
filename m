To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Robert E Brose II <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Dual G3's in Umax S900?
References: <20020502044441.3188.qmail@kunk.jriver.com>
	<20340830162052.29775@smtp.wanadoo.fr>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 02 May 2002 15:11:51 +0200
In-Reply-To: Benjamin Herrenschmidt's message of Thu, 2 May 2002 10:17:00 +0200
Message-ID: <8x1ycu1yp4.fsf@olof.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:


> No. Doing SMP with G3s is a terrible nightmare as those CPUs don't
> have the necessary coherency protocols.
>
Is MEI not enough for Linux? Instruction cache coherency problems? Or is it
because of the rudimentary implementation of tlbie/tlbia? Just curious.

  Holger


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
