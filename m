Message-ID: <3BE82BF7.5010207@mvista.com>
Date: Tue, 06 Nov 2001 13:29:11 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ibm405gp <ibm405.linux@laposte.net>
Cc: list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Abatron Bdi2000 and 405GP
References: <3BE7E505.DC9DE6E8@laposte.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ibm405gp wrote:

> ....i should be able to read any virtual adress, even if
> this adress is not present in the TLB. Am i right ? Any suggestion ?

Yes, yes.  Make sure you have the proper Abatron firmware.  We kind of
screwed up the Abatron folks when we moved some bits in the Linux PTE,
so be patient with them.  It wasn't their fault.

> 	lis	r5, abatron_pteptrs@ha


Uh, wait a minute....I'll bet you have the wrong kernel sources.  There is
a different set of sources for the 4xx (and other processors) from MontaVista
that fixes this cut'n'paste error I made here.  Ensure you are using the
proper source CD that matches the processor LSPs you have.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
