Message-ID: <3C4CF532.2040208@embeddededge.com>
Date: Tue, 22 Jan 2002 00:14:26 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux on 857T?
References: <C08678384BE7D311B4D70004ACA371050B7632A8@amer22.avnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kerl, John wrote:

> Hello,
>
> I am attempting a Linux port to a custom 857T board.  I've tried
> several different kernel trees, with the same results:  unhandled
> ITLB misses parking the CPU.

What do you mean "unhandled ITLB misses"?

The 857T _should_ work like an 860T with Ethernet either on the SCC or
the FEC (or both).  Of course, the reason to choose this part is you get both
parallel UTOPIA and FEC, which will require some software changes to enable
both of these functions.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
