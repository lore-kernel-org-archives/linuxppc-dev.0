From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: Robert E Brose II <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Dual G3's in Umax S900?
Date: Thu, 2 May 2002 15:14:39 +0200
Message-Id: <20020502131439.13109@smtp.adsl.oleane.com>
In-Reply-To: <8x1ycu1yp4.fsf@olof.informatik.uni-bremen.de>
References: <8x1ycu1yp4.fsf@olof.informatik.uni-bremen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> No. Doing SMP with G3s is a terrible nightmare as those CPUs don't
>> have the necessary coherency protocols.
>>
>Is MEI not enough for Linux? Instruction cache coherency problems? Or is it
>because of the rudimentary implementation of tlbie/tlbia? Just curious.

I don't have all in mind, from memory, the lack of bus broadcast for tlbie
is one, the lack of bus coherency for cache inval is another, but I am not
sure.

I think in the past, we used to have BeBox (dual 603) working, which I suppose
is pretty similar, but still hell. No way I support that for pmac kernels.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
