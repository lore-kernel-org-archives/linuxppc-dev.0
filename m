Message-ID: <3D4FE2EA.3070200@gmx.de>
Date: Tue, 06 Aug 2002 16:53:30 +0200
From: Michael Habermann <MHabermann@gmx.de>
MIME-Version: 1.0
To: Narendra <narengh@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: CS_BAD_VCC Error during Card Configaration.
References: <20020806113149.3218.qmail@webmail7.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Narendra wrote:
> occured when i try to write to WLAN card register. In this case
> Baseaddress returned
> is 0 and i have done the modifications to add _IO_BASE to the base
> address. (As mentioned
> in mail archives).

Have you checked which is really the value used for _IO_BASE? It is
configured several times in the kernel. The value in
include/asm/<board>.h has to be correct.

It maybe helps if you post the error and tell us which kernel and board
you use.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
